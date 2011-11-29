require 'spec_helper'

describe Module do

  describe "#include_and_extend" do
    it "should include class methods directly" do
      Second.should respond_to(:class_method)
    end


    it "should not include class methods indirectly" do
      Third.should respond_to(:class_method)
    end

    it "should include class methods" do
      Third.new.should respond_to(:instance_method)
    end
  end

  describe "#autoload_modules" do
    it "should autoload modules using :from => path" do
      require 'fixtures/autoload_modules'
      AutoloadModules::Third.should respond_to(:test)
    end

    it "should autoload modules from __FILE__'s dir if :from is omitted'" do
      require 'fixtures/autoload_modulez'
      AutoloadModulez::ThirdOneHere.should respond_to(:test)
    end

    context 'using AutoLoader.root' do
      it 'empty root' do
        SweetLoader.root = ''
        require 'autoload_blank_root'
        AutoloadBlankRoot::Hello.should respond_to(:test)
      end

      it 'should autoload modules using ClassExt#autoload_root' do
        SweetLoader.root = 'fixtures'
        require 'fixtures/autoload_modules_root'
        AutoloadModulesRoot::Third.should respond_to(:test)
      end
    end

    context 'using AutoLoader.namespaces' do
      it 'empty root' do
        SweetLoader.root = ''
        SweetLoader.namespaces= {:AutoLoadBlankRoot => 'autoload_blank_root', :HelloSailor => 'sailor'}
        require 'auto_load_blank_root'
        AutoLoadBlankRoot::HelloSailor.should respond_to(:test)
      end
    end
  end
end

describe ClassExt do
  describe '#try_module' do
    it "should return false if no module found" do
      trial.try_module('Blip').should be_false
      trial.try_module(:Blip).should be_false
      trial.try_module(nil).should be_false
    end

    it "should return module if found" do
      trial.try_module('GoodBye').should be_a(Module)
      trial.try_module(:GoodBye).should be_a(Module)       
    end

    it "should return namespaced module if found" do
      trial.try_module('GoodBye::Alpha::Beta').should be_a(Module)
    end

    it "should return false if only class of that name is found" do
      trial.try_module('Hello').should be_true
    end
  end

  describe '#try_class' do
    it "should return false if no class found" do
      trial.try_class('Blip').should be_false
      trial.try_class(:Blip).should be_false
      trial.try_class(nil).should be_false
    end

    it "should return class if found" do
      trial.try_class('Hello').should be_a(Class)
      trial.try_class(:Hello).should be_a(Class)
    end

    it "should return false if only class of that name is found" do
      trial.try_class('GoodBye').should be_false
    end
  end

  describe '#class_exists?' do
    it "should return false if no class found" do
      trial.class_exists?('Blip').should be_false
    end

    it "should return true if class found" do
      trial.class_exists?('Hello').should be_true
    end

    it "should return false if module found" do
      trial.class_exists?('GoodBye').should be_false
    end
  end

  describe '#module_exists?' do
    it "should return false if no module found" do
      trial.module_exists?('Blip').should be_false
    end

    it "should return true if module found" do
      trial.module_exists?('GoodBye').should be_true
    end

    it "should return false if only class found" do
      trial.module_exists?('Hello').should be_false
    end
  end

  describe '#try_module_only' do
    it 'should find module' do
      trial.try_module_only('Hello').should be_false
      trial.try_module_only('GoodBye').should be_true
    end
  end

  describe '#find_first_class' do
    it 'should find first class' do
      trial.find_first_class('GoodBye', 'Hello').should == Hello
    end

    it 'should not find any module' do
      lambda {trial.find_first_class('Good', 'Bye') }.should raise_error
    end
  end

  describe '#find_first_module' do
    it 'should find first module' do
      first_module = trial.find_first_module('GoodBye::Alpha::Beta', 'Hello')
      first_module.should == GoodBye::Alpha::Beta
    end

    it 'should not find any module' do
      lambda {trial.find_first_module('Good', 'Bye') }.should raise_error
    end
  end
end


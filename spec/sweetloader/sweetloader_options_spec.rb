require 'spec_helper'
require 'fixtures/autoload_mutate_path'

describe 'Sweetloader options' do
  describe "#autoload_modules" do    
    
    describe ':mutate_path argument' do
      specify do
        lambda { AutoloadModules::First.should respond_to(:test) }.should_not raise_error
      end
    end
    
    describe "#autoload_scope with :mutate_path options" do
      specify do
        lambda { AutoloadModules::Abc }.should_not raise_error
      end
    end

    describe "#autoload_scope with :namespace option" do
      specify do
        lambda { AutoloadModules::Configuration::Admin }.should_not raise_error
        lambda { AutoloadModules::Configuration::Editor }.should_not raise_error
      end
    end

    describe "#autoload_scope with :proc option" do
      specify do
        lambda { AutoloadModules::Procedure }.should_not raise_error
      end
    end
  end
end
module AutoloadModules
  autoload_modules :First, :mutate_path => Proc.new {|path| 'fixtures/autoload_modulez'}
end

module AutoloadModules
  autoload_scope :mutate_path => Proc.new {|path| 'fixtures/autoload_modulez'} do
    autoload_modules :Abc
    autoload_modules :Xyz
  end
  
  autoload_scope :proc => Proc.new {|the_module, module_name, require_file| require require_file } do 
    autoload_modules :Procedure
  end
end

module AutoloadModules
  module Configuration
    autoload_scope :ns => { :AutoloadModules => 'fixtures/autoload_modulez', :Configuration => 'roles/config/'} do
      autoload_modules :Admin
    end
    
    autoload_modules :Editor
  end
end

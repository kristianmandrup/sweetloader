module AutoloadModules
  autoload_modules :First, :mutate_path => Proc.new {|path| 'fixtures/autoload_modulez'}
end

module AutoloadModules
  autoload_scope :mutate_path => Proc.new {|path| 'fixtures/autoload_modulez'} do
    autoload_modules :Abc
    autoload_modules :Xyz
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

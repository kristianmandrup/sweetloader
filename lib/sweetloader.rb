require 'active_support/core_ext/string/inflections'


module SweetLoader
  def include_and_extend(the_module, options={})
    options[:instance_methods] ||= :InstanceMethods
    options[:class_methods] ||= :ClassMethods
    # Mainly include but be flexible
    main_module = const_get(the_module.to_s.to_sym)
    include main_module # for an extend_and_include method, change this to extend main_module
    include main_module.const_get(options[:instance_methods]) if main_module.const_defined?(options[:instance_methods])
    extend main_module.const_get(options[:class_methods]) if main_module.const_defined?(options[:class_methods])
  end

  def autoload_modules *args
    alm_options = args.extract_options!
    alm_options.merge!(autoload_options) if respond_to? :autoload_options

    root = alm_options[:root] || AutoLoader.root || ''
    path = root.strip.empty? ? self.name.to_s.underscore : [root, self.name.to_s.underscore].join('/')
    from = alm_options[:from] || path
    proc = alm_options[:mutate_path]
    from = proc.call(from) if proc
        
    the_module = send(:the_module) if respond_to? :the_module
    the_module ||= self
    
    # Here also could be adding of the file in top of load_paths like: $:.unshift File.dirname(__FILE__)
    # It is very useful for situations of having not load_paths built Rails or Gems way.
    args.each do |req_name|
      ruby_file = req_name.to_s.underscore
      require_file = AutoLoader.translate("#{from}/#{ruby_file}", alm_options)
      the_module.send :autoload, req_name, require_file
    end
  end
  alias_method :autoload_module, :autoload_modules
  
  def autoload_scope options = {}, &block
    if block_given?
      block.arity == 1 ? yield(self) : SweetLoader::Scope.new(self, options).instance_eval(&block)
    end    
  end  
end  
  
module SweetLoader
  class Scope
    include SweetLoader

    attr_reader :autoload_options, :the_module
  
    def initialize the_module, options = {}
      @the_module = the_module
      @autoload_options = options
    end
    
    def name
      the_module.name
    end
  end
end

class Module
  include SweetLoader
end

module AutoLoader
  @@root = ''
  @@namespaces = {}

  def self.root
    @@root
  end

  def self.namespaces
    @@namespaces
  end

  def self.root= root
    @@root = root
  end

  def self.namespaces= namespaces
    @@namespaces = namespaces
  end

  def self.translate name, options = {}    
    names = name.split('/')
    ns = namespaces.merge(options[:namespaces] || options[:ns] || {})
    names.map do |name|
      clazz_name = name.to_s.camelize
      folder = ns[clazz_name.to_sym] ? ns[clazz_name.to_sym] : name
      folder.sub /\/$/, ''
    end.join('/')
  end
end

module ClassExt
  class ModuleNotFoundError < StandardError; end
  class ClassNotFoundError < StandardError; end

  def get_module name
    # Module.const_get(name)
    name.to_s.camelize.constantize
  rescue
    nil
  end

  def is_class?(clazz)
    clazz.is_a?(Class) && (clazz.respond_to? :new)
  end

  def is_module?(clazz)
    clazz.is_a?(Module) && !(clazz.respond_to? :new)
  end

  def class_exists?(name)
    is_class? get_module(name)
  rescue
    return false
  end

  def module_exists?(name)
    is_module? get_module(name)
  rescue NameError
    return false
  end

  def try_class name
    return name if name.kind_of?(Class)
    found = get_module(name) if name.is_a?(String) || name.is_a?(Symbol)
    return found if found.is_a?(Class)
  rescue
    false
  end

  def try_module name
    return name if name.kind_of?(Module)
    found = get_module(name.to_s) if name.is_a?(String) || name.is_a?(Symbol)
    return found if found.is_a?(Module)
  rescue
    false
  end

  def try_module_only name
    return name if is_module?(name)
    found = get_module(name) if name.is_a?(String) || name.is_a?(Symbol)
    return found if is_module?(found)
  rescue
    false
  end


  def find_first_class *names
    classes = names.flatten.compact.uniq.inject([]) do |res, class_name|
      found_class = try_class(class_name.to_s.camelize)
      res << found_class if found_class
      res
    end
    raise ClassNotFoundError, "Not one Class for any of: #{names} is currently loaded" if classes.empty?
    classes.first
  end

  def find_first_module *names
    modules = names.flatten.compact.uniq.inject([]) do |res, class_name|
      found_class = try_module(class_name.to_s.camelize)
      res << found_class if found_class
      res
    end
    raise ModuleNotFoundError, "Not one Module for any of: #{names} is currently loaded" if modules.empty?
    modules.first
  end
end

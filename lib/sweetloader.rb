require 'active_support/core_ext/string/inflections'

require 'sweetloader/class_methods'

module SweetLoader
  class InvalidAutoloadMode < StandardError; end

  extend ClassMethods
  
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
    
    mode = alm_options[:mode] if AutoLoader.valid_mode? alm_options[:mode]
    mode ||= AutoLoader.mode
    
    logic = alm_options[:proc] if alm_options[:proc].respond_to? :call
    logic ||= mode_logic mode
    
    # Here also could be adding of the file in top of load_paths like: $:.unshift File.dirname(__FILE__)
    # It is very useful for situations of having not load_paths built Rails or Gems way.
    args.each do |module_name|
      ruby_file = module_name.to_s.underscore
      module_name = module_name.to_s.camelize.to_sym
      require_file = SweetLoader.translate("#{from}/#{ruby_file}", alm_options)
      logic.call(the_module, module_name, require_file)
    end
  end
  alias_method :autoload_module, :autoload_modules
  alias_method :sweetload, :autoload_modules

  def mode_logic mode
    case mode
    when :autoload
      Proc.new { |the_module, module_name, require_file| the_module.send :autoload, module_name, require_file }
    when :require
      Proc.new {|the_module, module_name, require_file| require require_file }
    else
      raise InvalidAutoloadMode, "Not a valid Autloader mode: #{AutoLoader.mode}, must be one of: #{AutoLoader.valid_mode}"
    end
  end
  
  def autoload_scope options = {}, &block
    if block_given?
      block.arity == 1 ? yield(self) : SweetLoader::Scope.new(self, options).instance_eval(&block)
    end
  end
  alias_method :sweetload_scope, :autoload_scope
  alias_method :sweet_scope, :autoload_scope
end

class Module
  include SweetLoader
end

# backwards (deprecated) alias
AutoLoader = SweetLoader

require 'sweetloader/scope'
require 'sweetloader/class_ext'

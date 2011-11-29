module SweetLoader
  module ClassMethods
    attr_writer :default_mode

    def translate name, options = {}    
      names = name.split('/')
      ns = namespaces.merge(options[:namespaces] || options[:ns] || {})
      names.map do |name|
        clazz_name = name.to_s.camelize
        folder = ns[clazz_name.to_sym] ? ns[clazz_name.to_sym] : name
        folder.sub /\/$/, ''
      end.join('/')
    end

    def root
      @root ||= ''
    end

    def root= root
      raise ArgumentError, "Must be a String, was: #{root}" if !root.kind_of?(String)
      @root = root
    end

    def namespaces
      @namespaces ||= {}
    end

    def namespaces= namespaces
      raise ArgumentError, "Must be a Hash, was: #{namespaces}" if !namespaces.kind_of?(Hash)
      @namespaces = namespaces
    end

    def mode
      @mode || default_mode
    end

    def mode= mode 
      @mode = mode if valid_mode? mode
    end

    def valid_mode? mode
      valid_modes.include? mode
    end

    def valid_modes
      [:autoload, :require]
    end
  
    def default_mode
      valid_modes.first
    end
  end
  extend ClassMethods
end
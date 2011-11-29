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

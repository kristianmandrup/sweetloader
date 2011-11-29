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
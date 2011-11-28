class Trial
  include ClassExt
end

class Hello
end

module GoodBye
  module Alpha
    module Beta
    end
  end
end

module First 
  module ClassMethods
    def class_method
    end
  end

  module InstanceMethods
    def instance_method
    end
  end
end

module Second
  include_and_extend First
end

class Third
  include_and_extend Second
end

def trial
  @trial ||= Trial.new
end
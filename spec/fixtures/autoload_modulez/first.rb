module AutoloadModulez
  module First
    def test
      puts "here is the test"
    end
  end
end

# for mutate_path test
module AutoloadModules
  module First
    def self.test
      puts "here is the test"
    end
  end
end  
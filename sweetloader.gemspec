# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sweetloader}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Kristian Mandrup}]
  s.date = %q{2011-12-04}
  s.description = %q{sweet autoloading using file structure conventions while allowing configuration overrides for special cases}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.mdown"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.mdown",
    "Rakefile",
    "VERSION",
    "lib/sweetloader.rb",
    "lib/sweetloader/class_ext.rb",
    "lib/sweetloader/class_methods.rb",
    "lib/sweetloader/scope.rb",
    "spec/auto_load_blank_root.rb",
    "spec/autoload_blank_root.rb",
    "spec/autoload_blank_root/hello.rb",
    "spec/autoload_blank_root/sailor.rb",
    "spec/autoload_modules/configuration/editor.rb",
    "spec/autoload_modules/procedure.rb",
    "spec/class_ext_spec.rb",
    "spec/fixtures/autoload_modules.rb",
    "spec/fixtures/autoload_modules/subdir/first.rb",
    "spec/fixtures/autoload_modules/subdir/second.rb",
    "spec/fixtures/autoload_modules/subdir/third.rb",
    "spec/fixtures/autoload_modules_root.rb",
    "spec/fixtures/autoload_modules_root/first.rb",
    "spec/fixtures/autoload_modules_root/second.rb",
    "spec/fixtures/autoload_modules_root/third.rb",
    "spec/fixtures/autoload_modulez.rb",
    "spec/fixtures/autoload_modulez/abc.rb",
    "spec/fixtures/autoload_modulez/first.rb",
    "spec/fixtures/autoload_modulez/roles/config/admin.rb",
    "spec/fixtures/autoload_modulez/second.rb",
    "spec/fixtures/autoload_modulez/third_one_here.rb",
    "spec/fixtures/autoload_modulez/xyz.rb",
    "spec/fixtures/autoload_mutate_path.rb",
    "spec/fixtures/models.rb",
    "spec/spec_helper.rb",
    "spec/sweetloader/sweetloader_options_spec.rb",
    "spec/sweetloader/sweetloader_spec.rb",
    "sweetloader.gemspec"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/sweetloader}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{sweetens up autoloading using file structure conventions}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.1"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.5.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.1.rc"])
      s.add_development_dependency(%q<jeweler>, [">= 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0.1"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.5.0"])
      s.add_dependency(%q<bundler>, [">= 1.1.rc"])
      s.add_dependency(%q<jeweler>, [">= 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0.1"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.5.0"])
    s.add_dependency(%q<bundler>, [">= 1.1.rc"])
    s.add_dependency(%q<jeweler>, [">= 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end


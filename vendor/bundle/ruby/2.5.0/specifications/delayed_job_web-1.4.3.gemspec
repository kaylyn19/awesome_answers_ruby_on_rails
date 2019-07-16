# -*- encoding: utf-8 -*-
# stub: delayed_job_web 1.4.3 ruby lib

Gem::Specification.new do |s|
  s.name = "delayed_job_web".freeze
  s.version = "1.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Erick Schmitt".freeze]
  s.date = "2018-06-11"
  s.description = "Web interface for delayed_job inspired by resque".freeze
  s.email = "ejschmitt@gmail.com".freeze
  s.executables = ["delayed_job_web".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.files = ["LICENSE.txt".freeze, "README.markdown".freeze, "bin/delayed_job_web".freeze]
  s.homepage = "https://github.com/ejschmitt/delayed_job_web".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Web interface for delayed_job inspired by resque".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>.freeze, [">= 1.4.4"])
      s.add_runtime_dependency(%q<rack-protection>.freeze, [">= 1.5.5"])
      s.add_runtime_dependency(%q<activerecord>.freeze, ["> 3.0.0"])
      s.add_runtime_dependency(%q<delayed_job>.freeze, ["> 2.0.3"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 4.2"])
      s.add_development_dependency(%q<rack-test>.freeze, ["~> 0.6"])
      s.add_development_dependency(%q<rails>.freeze, ["~> 4.0"])
    else
      s.add_dependency(%q<sinatra>.freeze, [">= 1.4.4"])
      s.add_dependency(%q<rack-protection>.freeze, [">= 1.5.5"])
      s.add_dependency(%q<activerecord>.freeze, ["> 3.0.0"])
      s.add_dependency(%q<delayed_job>.freeze, ["> 2.0.3"])
      s.add_dependency(%q<minitest>.freeze, ["~> 4.2"])
      s.add_dependency(%q<rack-test>.freeze, ["~> 0.6"])
      s.add_dependency(%q<rails>.freeze, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<sinatra>.freeze, [">= 1.4.4"])
    s.add_dependency(%q<rack-protection>.freeze, [">= 1.5.5"])
    s.add_dependency(%q<activerecord>.freeze, ["> 3.0.0"])
    s.add_dependency(%q<delayed_job>.freeze, ["> 2.0.3"])
    s.add_dependency(%q<minitest>.freeze, ["~> 4.2"])
    s.add_dependency(%q<rack-test>.freeze, ["~> 0.6"])
    s.add_dependency(%q<rails>.freeze, ["~> 4.0"])
  end
end

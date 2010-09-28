# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{context_assignment}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jan De Poorter", "Milo Winningham"]
  s.date = %q{2010-09-27}
  s.description = %q{Protect your attributes from mass_assignment per context. Sometimes you want an admin to be able to edit a users is_admin boolean field, but never the user himself. This is in-context attribute setting.}
  s.email = %q{github@defv.be}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "context_assignment.gemspec",
     "lib/active_record_extensions.rb",
     "lib/context_assignment.rb",
     "lib/mass_assignment_security.rb",
     "test/context_assignment_test.rb",
     "test/models/person.rb",
     "test/models/schema.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/DefV/context_assignment}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Protect your attributes from mass_assignment per context.}
  s.test_files = [
    "test/context_assignment_test.rb",
     "test/models/person.rb",
     "test/models/schema.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<activemodel>, ["~> 3.0.0"])
      s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<activemodel>, ["~> 3.0.0"])
    s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
  end
end


require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the context_assignment plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the context_assignment plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ContextAssignment'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |spec|
    spec.name = "context_assignment"
    spec.summary = "Protect your attributes from mass_assignment per context."
    spec.description = "Protect your attributes from mass_assignment per context. Sometimes you want an admin to be able to edit a users is_admin boolean field, but never the user himself. This is in-context attribute setting."
    spec.email = "github@defv.be"
    spec.homepage = "http://github.com/DefV/context_assignment"
    spec.authors = ["Jan De Poorter", "Milo Winningham"]
    
    spec.add_dependency('activesupport', '~>3.0.0')
    spec.add_dependency('activemodel', '~>3.0.0')
    spec.add_dependency('activerecord', '~>3.0.0')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
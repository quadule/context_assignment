require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'active_record/fixtures'

require 'context_assignment'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => ':memory:'
})


ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
  
  load 'models/schema.rb'
  load 'models/person.rb'
end
require 'active_support/core_ext/module/aliasing'

require File.join(File.dirname(__FILE__), 'mass_assignment_security')
require File.join(File.dirname(__FILE__), 'active_record_extensions')

ActiveRecord::Base.send :include, ActiveModel::MassAssignmentSecurity
ActiveRecord::Base.send :include, ContextAssignment::ActiveRecordExtensions
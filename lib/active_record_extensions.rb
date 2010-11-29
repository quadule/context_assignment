module ContextAssignment
  module ActiveRecordExtensions
    module ClassMethods
      def create_with_context(attributes, *args)
        # This isn't optimal but don't know how to fix this without re-implementing the whole create method
        create_without_context(attributes) do |object|
          object.define_assignment_context(args)
          object.send('attributes=', attributes)
          yield if block_given?
        end
      end
      
      def assignment_contexts
        (self._accessible_attributes || {}).keys + (self._protected_attributes || {}).keys
      end
    end
    
    def define_assignment_context(args)
      options = args.extract_options!
      if options[:context]
        raise "No such context: #{options[:context]}" unless self.class.assignment_contexts.include?(options[:context])
        @assignment_context = options[:context]
      end
    end
    
    def attributes_with_context=(attributes, *args)
      define_assignment_context(args)      
      send(:attributes_without_context=, attributes, *args)
    end
    
    def initialize_with_context(attributes = nil, *args)
      define_assignment_context(args)      
      initialize_without_context(attributes, *args)
    end
    
    def update_attributes_with_context(attributes, *args)
      define_assignment_context(args)
      update_attributes_without_context(attributes, *args)
    end
    
    def update_attributes_with_context!(attributes, *args)
      define_assignment_context(args)
      update_attributes_without_context!(attributes, *args)
    end
    
    def self.included(base)
      base.extend ClassMethods
      
      base.alias_method_chain :attributes=, :context
      base.alias_method_chain :initialize, :context
      base.alias_method_chain :update_attributes, :context
      base.alias_method_chain :update_attributes!, :context
      
      base.class_eval do
        class << self
          alias_method_chain :create, :context
        end
      end
    end
  end
end
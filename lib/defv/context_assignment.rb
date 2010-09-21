module Defv
  module ContextAssignment
    module ClassMethods
      def attr_protected_with_context(*attributes)
        options = attributes.extract_options!
        context = options[:context] || :default
        
        protected_attributes_with_context(context)
        self._protected_attributes[context] += attributes
        self._active_authorizer = self._protected_attributes
      end

      def protected_attributes_with_context(context = :default)
        blacklist = ActiveModel::MassAssignmentSecurity::BlackList.new(attributes_protected_by_default).tap do |l|
          l.logger = self.logger if self.respond_to?(:logger)
        end
        
        self._protected_attributes ||= { :default => blacklist.dup }
        self._protected_attributes[context] ||= blacklist
      end

      def attr_accessible_with_context(*attributes)
        options = attributes.extract_options!
        context = options[:context] || :default
        
        accessible_attributes_with_context(context)
        self._accessible_attributes[context] += attributes
        self._active_authorizer = self._accessible_attributes
      end

      def accessible_attributes_with_context(context = :default)
        whitelist = ActiveModel::MassAssignmentSecurity::WhiteList.new.tap do |l|
          l.logger = self.logger if self.respond_to?(:logger)
        end
        
        self._accessible_attributes ||= { :default => whitelist.dup }
        self._accessible_attributes[context] ||= whitelist
      end

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
      if options.has_key? :context
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
    
    def mass_assignment_authorizer
      self.class.active_authorizer[@assignment_context || :default]
    end

    def self.included(base)
      base.extend ClassMethods
   
      base.alias_method_chain :attributes=, :context
      base.alias_method_chain :initialize, :context
      base.alias_method_chain :update_attributes, :context
      base.alias_method_chain :update_attributes!, :context
    
      base.class_eval do
        class << self
          alias_method_chain :attr_protected, :context
          alias_method_chain :protected_attributes, :context
          alias_method_chain :attr_accessible, :context
          alias_method_chain :accessible_attributes, :context
          alias_method_chain :create, :context
        end
      end
    end
  end
end
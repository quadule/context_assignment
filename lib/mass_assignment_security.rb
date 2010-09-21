module ActiveModel
  module MassAssignmentSecurity
    extend ActiveModel::MassAssignmentSecurity
    
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
    end
    
    def mass_assignment_authorizer
      self.class.active_authorizer[@assignment_context || :default]
    end
    
    def self.included(base)
      base.extend ClassMethods
      
      base.class_eval do
        class << self
          alias_method_chain :attr_protected, :context
          alias_method_chain :protected_attributes, :context
          alias_method_chain :attr_accessible, :context
          alias_method_chain :accessible_attributes, :context
        end
      end
    end
  end
end
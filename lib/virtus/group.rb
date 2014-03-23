require "active_support/core_ext/class"
require "virtus/group/version"
require "virtus/group/attribute_tracker"

module Virtus

  # stick to virtus api
  def self.group
    mod = Module.new
    mod.define_singleton_method :included do |object|
      object.send(:include, Group)
    end
    mod
  end

  module Group

    def self.included(base)
      base.class_eval do
        extend ClassMethods

        class_attribute :attribute_groups
      end
    end

    module ClassMethods

      def group(name, &block)
        attribute_tracker = AttributeTracker.new(self, &block)
        attribute_group[name] = attribute_tracker.tracked_attributes
      end

      def attribute_group
        self.attribute_groups ||= {}
      end

    end

    def attributes_for(group_name)
      attributes_in_group = self.class.attribute_group[group_name.to_sym]
      self.attributes.select{|attribute, _| attributes_in_group.include?(attribute)}
    end
    alias :with_attributes_for :attributes_for

  end
end

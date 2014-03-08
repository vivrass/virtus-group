require "virtus/group/version"

module Virtus

  # keep virtus api
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
      end
    end

    module ClassMethods

      def group(name, &block)
        name
      end

    end

    def attribute_group

    end

  end
end

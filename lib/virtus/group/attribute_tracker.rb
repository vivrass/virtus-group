require 'delegate'

module Virtus
  module Group

    class AttributeTracker < SimpleDelegator

      def initialize(clazz, &block)
        super(clazz)
        instance_eval(&block)
      end

      def attribute(*args)
        tracked_attributes << args.first.to_sym
        super
      end

      def tracked_attributes
        @tracked_attributes ||= []
      end

    end

  end
end

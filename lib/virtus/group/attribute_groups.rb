module Virtus
  module Group

    class AttributeGroups

      def for_class(clazz)
        mapping[clazz] ||= {}
      end

      def mapping
        @mapping ||= {}
      end

    end

  end
end


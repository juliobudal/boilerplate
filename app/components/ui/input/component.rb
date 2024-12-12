module Ui
  module Input
    class Component < ::Ui::BaseComponent
      def initialize(form:, field:, type: :text, label: nil, hint: nil, error: nil, **options)
        @form = form
        @field = field
        @type = type
        @label = label
        @hint = hint
        @error = error
        @options = options
      end

      private

      def input_classes
        [
          "block w-full rounded-md sm:text-sm",
          if @error
            "border-red-300 text-red-900 placeholder-red-300 focus:border-red-500 focus:ring-red-500"
          else
            "border-gray-300 focus:border-primary-500 focus:ring-primary-500"
          end
        ].join(" ")
      end

      def label_classes
        "block text-sm font-medium text-gray-700"
      end

      def hint_classes
        "mt-2 text-sm text-gray-500"
      end

      def error_classes
        "mt-2 text-sm text-red-600"
      end
    end
  end
end

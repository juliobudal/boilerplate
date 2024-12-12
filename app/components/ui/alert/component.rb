module Ui
  module Alert
    class Component < ::Ui::BaseComponent
      VARIANTS = {
        info: "text-blue-700 bg-blue-100",
        success: "text-green-700 bg-green-100",
        warning: "text-yellow-700 bg-yellow-100",
        error: "text-red-700 bg-red-100"
      }.freeze

      def initialize(type: :info, message:, dismissible: false, **options)
        @type = type
        @message = message
        @dismissible = dismissible
        @options = options
      end

      private

      def classes
        [
          "p-4 rounded-md",
          VARIANTS[@type],
          @options[:class]
        ].compact.join(" ")
      end
    end
  end
end

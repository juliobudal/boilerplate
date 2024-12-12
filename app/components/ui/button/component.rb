module Ui
  module Button
    class Component < ::Ui::BaseComponent
      VARIANTS = {
        primary: "text-white bg-primary-600 hover:bg-primary-700 focus:ring-primary-600",
        secondary: "text-gray-700 bg-white hover:bg-gray-50 focus:ring-primary-600 border-gray-300 border",
        danger: "text-white bg-red-600 hover:bg-red-700 focus:ring-red-500"
      }.freeze

      SIZES = {
        sm: "px-3 py-2 text-sm",
        md: "px-4 py-2 text-sm",
        lg: "px-6 py-3 text-base"
      }.freeze

      def initialize(variant: :primary, size: :md, full_width: false, **options)
        @variant = variant
        @size = size
        @full_width = full_width
        @options = options
      end

      def call
        if @options[:as] == :button
          button_tag(content, class: classes, type: @options[:type] || "button", **@options.except(:as, :class, :type))
        else
          link_to(@options[:href], class: classes, **@options.except(:as, :class, :href)) { content }
        end
      end

      private

      def classes
        [
          "inline-flex items-center justify-center font-medium rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2",
          VARIANTS[@variant],
          SIZES[@size],
          @full_width ? "w-full" : "",
          @options[:class]
        ].compact.join(" ")
      end
    end
  end
end

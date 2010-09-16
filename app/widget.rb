module Chat
  module Widget
    module InputGrid
      def self.included(base)
        base.after_initialize { @label_options.merge! :class => %w[grid_2] }
      end

      def field
        div :class => %w{grid_3} do
          super
        end
      end

      def content
        super
        div :class => 'clear'
      end

    end

    [:Field, :Select, :Password, :Textarea].each do |klass|
      const_set(klass, Class.new(Hammer::Widget::Form.const_get(klass))).class_eval do
        include InputGrid
      end
    end

    Hidden = Hammer::Widget::Form::Hidden

    class Textarea
      css do
        div { height '90px' }
        textarea { height '66px' }
      end
    end
  end
end
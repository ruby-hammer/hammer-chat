module Hammer::Widget::Form
  class Hidden < Field
    def type
      :hidden
    end

    def render_label
    end
  end
end

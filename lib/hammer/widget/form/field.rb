module Hammer::Widget::Form
  class Field < Abstract
    def content
      render_label
      input({ :name => @value, :value => value(@value), :type => type, :id => @label_id }.merge(@options))
    end

    def type
      :text
    end
  end
end

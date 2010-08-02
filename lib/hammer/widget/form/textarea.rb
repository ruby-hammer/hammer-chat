module Hammer::Widget::Form
  class Textarea < Abstract
    def content
      render_label
      textarea(value(@value), { :type => @type, :name => @value, :id => @label_id }.merge(@options))
    end
  end
end

module Hammer::Widget::Form
  class Select < Abstract
    needs :select_options

    def content
      render_label
      select({ :value => value(@value), :name => @value, :id => @label_id }.merge(@options)) do
        options_for_select
      end
    end

    protected

    def options_for_select
      @select_options.each do |opt|
        value, text = opt
        text ||= value
        option text, :value => value, :selected => value(@value) == value ? :selected : false
      end
    end

  end
end

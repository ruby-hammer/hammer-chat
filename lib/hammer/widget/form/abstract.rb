module Hammer::Widget::Form
  class Abstract < Hammer::Widget::Base
    wrap_in(:div)
    needs \
        :value => :value,
        :options => {},
        :label => nil

    def render_label
      label @label, :for => @label_id = Hammer::Core.generate_id if @label
    end

  end
end
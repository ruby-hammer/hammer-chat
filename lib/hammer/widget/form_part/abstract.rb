module Hammer::Widget::FormPart
  class Abstract < Hammer::Widget::Base
    wrap_in(:span)
    needs \
        :value => :value,
        :options => {}
  end
end
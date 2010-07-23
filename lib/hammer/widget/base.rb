# encoding: UTF-8

module Hammer::Widget

  class Base < Abstract
    include Hammer::Widget::Wrapping
    include Hammer::Widget::Component
    include Hammer::Widget::Callback
  end

end
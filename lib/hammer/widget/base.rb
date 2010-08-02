# encoding: UTF-8

module Hammer::Widget

  class Base < Abstract
    include Hammer::Widget::Wrapping
    include Hammer::Widget::Component
    # include Hammer::Widget::ElementBuilder
    include Hammer::Widget::JQuery

    include Hammer::Widget::Helper::LinkTo
    include Hammer::Widget::Helper::Submit
  end

end
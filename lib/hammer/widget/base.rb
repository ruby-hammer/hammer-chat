# encoding: UTF-8

module Hammer::Widget

  class Base < Abstract
    include Hammer::SubClasses
    include Wrapping
    include Component
    # include Hammer::Widget::ElementBuilder
    include JQuery
    include CSS

    include Helper::LinkTo
    include Helper::Submit
  end

end
# encoding: UTF-8

module Hammer::Component

  # represents component of a page. The basic logic building blocks of a application.
  class Base < Abstract
    include Rendering
    include Answer
    include Passing
    include Inspection

    const_set :Widget, Hammer::Widget::Base
  end
end

module Hammer::Widget
  def self.all
    Hammer::Widget::Base.all_sub_classes
  end
end
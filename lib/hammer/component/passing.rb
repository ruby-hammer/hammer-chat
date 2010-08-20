module Hammer::Component::Passing

  def self.included(base)
    base.children :passed_on
    base.send :attr_reader, :passed_on
    base.extend ClassMethods
  end

  module ClassMethods
    def extend_widget(widget_class)
      super
      widget_class.send :include, Widget unless widget_class.include? Widget
    end
  end

  module Widget
    def render_component(component)
      super self.component.passed? ? self.component.passed_on : component
    end
  end

  # rendering is passed on to +component+. Usually used with ask.
  # @return [Base]
  # @example
  #   pass_on ask(Login, Model::User.new) { |user|
  #     do_something_with_returned_user
  #     retake_control!
  #   }
  def pass_on(component)
    @passed_on = component
  end

  # see {#pass_on}
  def retake_control!
    @passed_on = nil
  end

  # @return [Boolean] is component passing?
  def passed?
    @passed_on.present?
  end

  def to_html(options = {})
    passed? ? passed_on.to_html(options) : super
  end

end
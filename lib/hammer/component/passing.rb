module Hammer::Component::Passing

  # pass on if {#passed?}
  def to_html
    @passed_on ? @passed_on.to_html : super
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

end
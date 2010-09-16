# encoding: UTF-8

class Chat::Layout < Hammer::Widget::Layout

  depends_on :css, 'css/960/reset.css'
  depends_on :css, 'css/960/960.css'
  depends_on :css, 'css/base.css'
  generated_css

  def page_title
    "Hammer - Chat"
  end

  def container(&content)
#    div :class => 'container_16 showgrid', &content
    div :class => 'container_16', &content
  end

end
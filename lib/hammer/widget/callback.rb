# adds capability to generate callback on tags
module Hammer::Widget::Callback

  # @param [Symbol] event jQuery event like :click, :change, etc.
  # @param [Object] form_id to update on +event+. It can be an object where its #object_id is used or id
  # @yield block action to be executed on +event+
  # @example a action callback
  #   a "Log", :callback => on(:click) { @tool = new Hammer::Component::Developer::Log }
  # @example a form actualization
  #   a "Send", :callback => on(:click, a_form_id)
  def on(event, form_id = nil, &block)
    hash = {}
    hash[:action] = register_action &block if block
    hash[:form] = form_id.is_a?(Fixnum) ? form_id : form_id.object_id if form_id
    [ event, hash ]
  end

  protected

  # catches callbacks
  def __element__(raw, tag_name, *args, &block)
    if (attributes = args.last.is_a?(Hash) ? args.last : nil) && attributes[:callback]
      format_callbacks!(attributes)
    end
    super(raw, tag_name, *args, &block)
  end

  # catches callbacks
  def __empty_element__(tag_name, attributes={})
    if attributes[:callback]
      format_callbacks!(attributes)
    end
    super(tag_name, attributes)
  end

  private

  # formats callback in attributes for an element
  def format_callbacks!(attributes)
    event, hash = attributes.delete(:callback)
    attributes.merge! :"data-callback-#{event}" => simple_json(hash)
  end

  # transforms Hash to JSON
  # @param [Hash] hash one-level hash with primitive types
  def simple_json(hash)
    str = hash.inject('{') {|str, pair| str << pair[0].to_s.inspect << ':' << pair[1].inspect << "," }
    str[-1] = '}'
    str
  end

end
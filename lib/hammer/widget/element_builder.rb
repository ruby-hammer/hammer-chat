# adds capability to generate callback on tags
module Hammer::Widget::ElementBuilder

  #  # @param [Symbol] event jQuery event like :click, :change, etc.
  #  # @param [Object] form_id to update on +event+. It can be an object where its #object_id is used or id
  #  # @yield block action to be executed on +event+
  #  # @example a action callback
  #  #   a "Log", :callback => on(:click) { @tool = new Hammer::Component::Developer::Log }
  #  # @example a form actualization
  #  #   a "Send", :callback => on(:click, a_form_id)
  #  def on(event, form_id = nil, &block)
  #    hash = {}
  #    hash[:action] = register_action &block if block
  #    hash[:form] = form_id.is_a?(Fixnum) ? form_id : form_id.object_id if form_id
  #    [ event, hash ]
  #  end
  #
  #  protected
  #
  #  # catches callbacks
  #  def __element__(raw, tag_name, *args, &block)
  #    if (attributes = args.last.is_a?(Hash) ? args.last : nil) && attributes[:callback]
  #      format_callbacks!(attributes)
  #    end
  #    super(raw, tag_name, *args, &block)
  #  end
  #
  #  # catches callbacks
  #  def __empty_element__(tag_name, attributes={})
  #    if attributes[:callback]
  #      format_callbacks!(attributes)
  #    end
  #    super(tag_name, attributes)
  #  end
  #
  #  private
  #
  #  # formats callback in attributes for an element
  #  def format_callbacks!(attributes)
  #    event, hash = attributes.delete(:callback)
  #    attributes.merge! :"data-callback-#{event}" => simple_json(hash)
  #  end
  #
  #  # transforms Hash to JSON
  #  # @param [Hash] hash one-level hash with primitive types
  #  def simple_json(hash)
  #    str = hash.inject('{') {|str, pair| str << pair[0].to_s.inspect << ':' << pair[1].inspect << "," }
  #    str[-1] = '}'
  #    str
  #  end

  def self.included(base)
    base.all_tags.each do |tag|
      base.class_eval(<<-SRC, __FILE__, __LINE__ + 1)
        def #{tag}!(*args, &block)
          element_builder('#{tag}', *args, &block)
        end
      SRC
    end
  end

  private

  def element_builder(tag, *args, &block)
    Builder.new(self, tag, *args, &block)
  end

  class Builder
    def initialize(widget, tag, *args, &block)
      @widget, @tag, @options, @value, @block  = widget, tag, args.extract_options!, args.first, block
    end

    def js(&block)
      @options[:'data-js'] = @widget.jquery &block
      self
    end

    def flush!
      @widget.send @tag, *[@value, @options], &@block
    end

    def action(&block)
      @options[:'data-action-id'] = @widget.register_action &block
      self
    end

    def method_missing(method, *args, &block)
      method.to_s =~ /(.+)!$/
      if $1 && respond_to?($1)
        send $1, *args, &block
        flush!
      else
        super
      end
    end

    def respond_to?(symbol, include_private = false)
      symbol.to_s =~ /(.+)!$/
      ($1 && respond_to?($1)) || super
    end

  end

end
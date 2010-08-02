module Hammer::Widget::Helper::Submit

  def self.included(base)
    Hammer::Widget::Layout.class_eval do
      depends_on :script, jquery {
        jQuery('input[type="submit"][data-form-id]').live('click', function(event) {
            event.preventDefault!
            jQuery(event.target).hammer.action!.hammer.form!.hammer.send! # TODO why this don't work in other order
          })
      }
    end
  end

  def submit(value, options = {}, &block)
    Submit.new self, value, options, &block
  end

  class Submit
    def initialize(widget, value, options, &block)
      @widget, @value, @options, @block = widget, value, options, block
    end

    def update(form_id = @widget.component.object_id, &block)
      @options.merge! :type => :submit, :value => @value
      @options[:'data-form-id'] = form_id
      @options[:'data-action-id'] = @widget.register_action &block if block
      @widget.input(@options, &@block)
    end
  end

end
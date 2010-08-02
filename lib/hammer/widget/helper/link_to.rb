module Hammer::Widget::Helper::LinkTo

  def self.included(base)
    Hammer::Widget::Layout.class_eval do
      depends_on :script, jquery {
        jQuery("a[data-action-id]").live('click', function(event) {
            event.preventDefault!
            jQuery(event.target).hammer.action!.hammer.send!
          })
      }
    end
  end

  def link_to(*args, &block)
    LinkTo.new self, *args, &block
  end

  class LinkTo
    def initialize(widget, *args, &block)
      @widget, @args, @block = widget, args, block
    end

    def action(&block)
      options = @args.extract_options!
      options[:'data-action-id'] = @widget.register_action &block
      @widget.a(*@args.push(options), &@block)
    end
  end

end
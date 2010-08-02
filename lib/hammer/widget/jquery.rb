module Hammer::Widget::JQuery

  def self.included(base)
    base.extend self
  end

  # @return [String] generated js. It doesn't support operators and loops,
  # its goal is to generate function calls.
  # @yield block ruby generating js
  # @examples
  #   jquery { jquery.jq! } # => "jQuery.jQuery()"
  #   jquery { a(1 => "a", :b => [1,2]) # => "a({\"1\":\"a\",\"b\":[1,2]})"
  #   jquery { b(a!, a); a.c(b(c)); } # => "b(a(),a);a.c(b(c));"
  #   jquery { b(function(b!, :a) {b!.c!} } # => "b(function(b(), "a") {b().c();});"
  def jquery(&block)
    Generator.new(self, &block).to_s
  end

  class Abstract

    def _format_args(*args)
      args.map do |arg|
        if arg.kind_of?(Generator) || arg.kind_of?(MethodStack)
          arg.to_js
        else
          arg.to_json
        end
      end.join ','
    end
  end

  class Generator < Abstract
    attr_reader :widget
    def initialize(widget, &block)
      @widget, @stacks = widget, []
      instance_eval &block
    end

    def method_missing(method, *args)
      @stacks << stack = MethodStack.new
      stack.send(method, *args)
      stack
    end

    def function(*args, &block)
      Function.new(@widget, *args, &block)
    end
    alias_method(:fn, :function)

    def to_js
      to_s
    end

    def to_s
      @stacks.map(&:to_js).compact.join(';') << ';'
    end
  end

  class Function < Generator
    def initialize(widget, *args, &block)
      @args = args
      super(widget, &block)
    end

    def to_s
      "function(#{_format_args(*@args)}) {#{super}}"
    end
  end

  class MethodStack < Abstract
    def initialize
      @methods = []
    end

    def method_missing(method, *args)
      _method(method, *args)
    end

    def to_js
      return nil if used?
      @used = true
      to_s
    end

    def to_s
      @methods.join('.')
    end

    def used?
      @used
    end

    private

    ALIASES = {
      'jquery' => 'jQuery',
      'jq' => 'jQuery',
    }

    def _method(method, *args)
      method.to_s =~ /([\w_$]+)(!|)/
      method = ALIASES[$1] || $1
      if args.blank? && $2.blank?
        @methods << method
      else
        @methods << "#{method}(#{_format_args(*args)})"
      end
      self
    end

  end

end
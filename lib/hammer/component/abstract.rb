# encoding: UTF-8

module Hammer::Component

  class SuperAbstract
    include Erector::Needs
    include Erector::AfterInitialize
  end

  # represents component of a page. The basic logic building blocks of a application.
  class Abstract < SuperAbstract

    needs :context
    attr_reader :context

    def initialize(assigns = {})
      check_assigns(assigns)
      @_assigns = assigns

      assigns.each do |name, value|
        instance_variable_set(name.to_s[0] == '@' ? name : "@#{name}", value)
      end

      super
    end

    # {Base} factory method, it adds proper {Core::Context} automatically
    # @param [Hash] assigns are passed to +klass+.new
    # @param [Class] klass which is used to create new {Base} instance
    def new(klass, assigns = {})
      check_assigns(assigns)
      klass.send :new, assigns.merge({:context => context})
    end

    private

    def check_assigns(assigns)
      unless assigns.kind_of? Hash
        raise "assigns is not a Hash: #{assigns.inspect}"
      end
    end

  end
end

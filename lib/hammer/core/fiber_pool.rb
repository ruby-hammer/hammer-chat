module Hammer::Core
  class Fiber < ::Fiber
    attr_accessor :hammer_context
  end

  class FiberPool

    # gives access to the currently free fibers
    attr_reader :fibers

    # Prepare a list of fibers that are able to run different blocks of code
    # every time. Once a fiber is done with its block, it attempts to fetch
    # another one from the queue
    def initialize(count = 50)
      @busy_fibers, @queue = {}, []

      @fibers = Array.new(count) do
        Fiber.new do |block|
          loop do
            block.call
            unless @queue.empty?
              block = @queue.shift
            else
              @busy_fibers.delete(Fiber.current.object_id)
              @fibers << Fiber.current
              block = Fiber.yield
            end
          end
        end
      end
    end

    # If there is an available fiber use it, otherwise, leave it to linger in a queue
    def spawn(&block)
      if fiber = @fibers.shift
        @busy_fibers[fiber.object_id] = fiber
        fiber.resume(block)
      else
        @queue << block
      end
      self # we are keen on hiding our queue
    end

  end # FiberPool
end


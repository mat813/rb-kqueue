module KQueue
  class Event
    def initialize(native, queue)
      @native = native
      @queue = queue
    end
  end
end

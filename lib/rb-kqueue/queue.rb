module KQueue
  class Queue
    attr_reader :fd

    def initialize
      @fd = Native.kqueue
    end

    def watch_for_change(path, *flags)
      Watcher::VNode.new(self, path, flags)
    end

    def read_events
      size = 1024
      eventlist = FFI::MemoryPointer.new(Native::KEvent, size)
      res = Native.kevent(@fd, nil, 0, eventlist, size, nil)

      KQueue.handle_error if res < 0
      (0...res).map {|i| KQueue::Event.new(Native::KEvent.new(eventlist[i]), self)}
    end
  end
end

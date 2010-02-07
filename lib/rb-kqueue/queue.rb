module KQueue
  class Queue
    def initialize
      @kq = Native.kqueue
      @events = []
    end

    def register(event)
      @events << event
    end

    def read_events
      changelist = FFI::MemoryPointer.new(Native::KEvent, @events.size)
      @events.each_with_index {|e, i| e.write_to(changelist[i])}

      size = 1024
      eventlist = FFI::MemoryPointer.new(Native::KEvent, size)
      res = Native.kevent(@kq, changelist, @events.size, eventlist, size, nil)

      return (0...res).map {|i| Native::KEvent.new(eventlist[i])} unless res < 0

      raise SystemCallError.new(
        "KQueue failed" +
        case FFI.errno
        when Errno::EFAULT::Errno; ": There was an error reading or writing the kevent structure."
        when Errno::EBADF::Errno; ": The specified descriptor is invalid."
        when Errno::EINTR::Errno; ": A signal was delivered before the timeout expired and before any events were placed on the kqueue for return."
        when Errno::EINVAL::Errno; ": The specified time limit or filter is invalid."
        when Errno::ENOENT::Errno; ": The event could not be found to be modified or deleted."
        when Errno::ENOMEM::Errno; ": No memory was available to register the event."
        when Errno::ESRCH::Errno; ": The specified process to attach to does not exist."
        else; ""
        end,
        FFI.errno)
    end
  end
end

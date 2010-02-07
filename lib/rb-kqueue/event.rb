module KQueue
  class Event
    attr_reader :data

    def watcher
      @watcher ||= @queue.watchers[[filter, @native[:ident]]]
    end

    def filter
      @filter ||= KQueue::Native::Flags.from_flag("EVFILT", @native[:filter])
    end

    def flags
      @flags ||= Native::Flags.from_mask("NOTE", @native[:fflags])
    end

    def initialize(native, queue)
      @native = native
      @queue = queue
      @data = @native[:data]

      KQueue.handle_error @native[:data] if @native[:flags] & Native::Flags::EV_ERROR != 0
    end

    def callback!
      watcher.callback! self
    end
  end
end

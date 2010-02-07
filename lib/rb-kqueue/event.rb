module KQueue
  class Event
    attr_reader :data
    attr_reader :filter

    def watcher
      @watcher ||= @queue.watchers[[filter, @native[:ident]]]
    end

    def flags
      @fflags ||= Native::Flags.from_mask("NOTE", @native[:fflags])
    end

    def eof?
      @flags.include?(:eof)
    end

    def initialize(native, queue)
      @native = native
      @queue = queue
      @data = @native[:data]
      @filter = KQueue::Native::Flags.from_flag("EVFILT", @native[:filter])
      @flags = Native::Flags.from_mask("EV", @native[:flags])

      KQueue.handle_error @native[:data] if @flags.inclue?(:error)
    end

    def callback!
      watcher.callback! self
    end
  end
end

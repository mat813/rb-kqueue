module KQueue
  class Event
    def watcher
      @watcher ||= @queue.watchers[[filter, @native[:ident]]]
    end

    def filter
      @filter ||= KQueue::Native::Flags.from_flag("EVFILT", @native[:filter])
    end

    def initialize(native, queue)
      @native = native
      @queue = queue

      KQueue.handle_error @native[:data] if @native[:flags] & Native::Flags::EV_ERROR != 0
    end

    def callback!
      watcher.callback! self
    end
  end
end

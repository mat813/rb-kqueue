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
    end
  end
end

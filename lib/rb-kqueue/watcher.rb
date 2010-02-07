module KQueue
  class Watcher
    def initialize(queue, ident, filter, fflags, data)
      @queue = queue
      @ident = ident
      @filter = filter
      @flags = []
      @fflags = fflags
      @data = data
      add!
    end

    def add!
      kqueue! :add
      @queue.watchers[[@filter, @ident]] = self
    end

    def remove!
      kqueue! :add
      @queue.watchers.delete([@filter, @ident])
    end

    def enable!
      kqueue! :enable
    end

    def disable!
      kqueue! :disable
    end

    private

    def native(flags)
      native = Native::KEvent.new
      native[:ident] = @ident
      native[:filter] = Native::Flags.to_flag("EVFILT", @filter)
      native[:flags] = Native::Flags.to_mask("EV", @flags | flags)
      native[:fflags] = Native::Flags.to_mask("NOTE", @fflags)
      native[:data] = @data if @data
      native
    end

    def kqueue!(*flags)
      if Native.kevent(@queue.fd, native(flags).pointer, 1, nil, 0, nil) < 0
        KQueue.handle_error
      end
    end
  end
end

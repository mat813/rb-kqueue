module KQueue
  class Event
    def initialize(ident, filter, flags, fflags)
      @ident = ident
      @filter = filter
      @flags = flags
      @fflags = fflags
    end

    def write_to(ptr)
      native = Native::KEvent.new(ptr)
      native[:ident] = @ident
      native[:filter] = Native::Flags.to_mask("EVFILT", [@filter])
      native[:flags] = Native::Flags.to_mask("EV", @flags)
      native[:fflags] = Native::Flags.to_mask("NOTE", @fflags)
      native[:udata] = @udata
    end
  end
end

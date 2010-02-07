require 'ffi'

module KQueue
  module Native
    extend FFI::Library

    class KEvent < FFI::Struct
      layout(
        :ident,  :uintptr_t,
        :filter, :int16,
        :flags,  :uint16,
        :fflags, :uint32,
        :data,   :intptr_t,
        :udata,  :pointer)
    end

    class TimeSpec < FFI::Struct
      layout(
        :tv_sec, :time_t,
        :tv_nsec, :long)
    end

    attach_function :kqueue, [], :int
    attach_function :kevent, [:int, :pointer, :int, :pointer, :int, :pointer], :int
  end
end

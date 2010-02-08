module KQueue
  class Watcher
    class SocketReadWrite < ReadWrite
      attr_reader :low_water

      def initialize(queue, fd, type, low_water, callback)
        @fd = fd
        @type = type

        if low_water
          fflags = [:lowat]
          data = low_water
        else
          fflags = []
          data = nil
        end

        super(queue, @fd, type, fflags, data, callback)
      end
    end
  end
end

module KQueue
  class Watcher
    class Read < Watcher
      attr_reader :fd
      attr_reader :low_water

      def initialize(queue, fd, low_water, callback)
        @fd = fd
        @low_water = low_water

        if low_water
          fflags = [:lowat]
          data = low_water
        else
          fflags = []
          data = nil
        end
          
        super(queue, @fd, :read, fflags, data, callback)
      end
    end
  end
end

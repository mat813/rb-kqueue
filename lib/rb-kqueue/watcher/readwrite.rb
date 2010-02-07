module KQueue
  class Watcher
    class ReadWrite < Watcher
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
          
        super(queue, @fd, filter, fflags, data, callback)
      end

      private

      def filter
        raise "Subclasses of KQueue::Watcher::ReadWrite must override #filter."
      end
    end
  end
end

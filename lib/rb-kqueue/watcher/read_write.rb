module KQueue
  class Watcher
    class ReadWrite < Watcher
      attr_reader :fd
      attr_reader :type

      def initialize(queue, fd, type, callback)
        @fd = fd
        @type = type
        super(queue, @fd, type, [], nil, callback)
      end
    end
  end
end

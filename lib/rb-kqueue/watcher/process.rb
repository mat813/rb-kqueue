module KQueue
  class Watcher
    class Process < Watcher
      attr_reader :pid

      def initialize(queue, pid, flags, callback)
        @pid = pid
        super(queue, pid, :proc, flags, nil, callback)
      end
    end
  end
end

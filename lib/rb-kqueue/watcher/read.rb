module KQueue
  class Watcher
    class Read < ReadWrite
      private

      def filter; :read; end
    end
  end
end

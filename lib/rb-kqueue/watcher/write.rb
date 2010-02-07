module KQueue
  class Watcher
    class Write < ReadWrite
      private

      def filter; :write; end
    end
  end
end

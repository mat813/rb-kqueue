module KQueue
  class Watcher
    class VNode < Watcher
      attr_reader :path

      def initialize(queue, path, flags)
        @path = path
        @file = File.open(path) # TODO: not JRuby-compatible
        super(queue, @file.fileno, :vnode, flags, nil)
      end
    end
  end
end

module KQueue
  class Watcher
    class VNode < Watcher
      attr_reader :path

      def initialize(queue, path, flags, callback)
        @path = path
        @file = File.open(path) # TODO: not JRuby-compatible
        super(queue, @file.fileno, :vnode, flags, nil, callback)
      end
    end
  end
end

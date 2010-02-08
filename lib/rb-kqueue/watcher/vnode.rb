module KQueue
  class Watcher
    # The {Watcher} subclass for events fired when a file changes.
    # File events are watched via {Queue#watch_file}.
    class VNode < Watcher
      # The path to the file being watched.
      #
      # @return [String]
      attr_reader :path

      # Creates a new file Watcher.
      #
      # @private
      def initialize(queue, path, flags, callback)
        @path = path
        @file = File.open(path) # TODO: not JRuby-compatible
        super(queue, @file.fileno, :vnode, flags, nil, callback)
      end
    end
  end
end

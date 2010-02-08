# rb-kqueue

This is a simple wrapper over the [kqueue](http://en.wikipedia.org/wiki/Kqueue)
BSD event notification interface (supported on FreeBSD, NetBSD, OpenBSD, and Darwin).
It uses the [FFI](http://wiki.github.com/ffi/ffi) gem to avoid having to compile a C extension.

[API documentation is available on rdoc.info](http://rdoc.info/projects/nex3/rb-kqueue).

## Usage

The API is similar to the kqueue C API, but with a more Rubyish feel.
First, create a queue:

    queue = KQueue::Queue.new

Then, tell it to watch the events you're interested in:

    queue.watch_for_file_change("path/to/foo.txt", :write) {puts "foo.txt was modified!"}
    queue.watch_for_process_change(Process.pid, :fork, :exec) do |event|
      puts "This process has #{event.flags.map {|f| f.to_s + "ed"}.join(" and ")}"
    end

KQueue can monitor for all sorts of events.
For a full list, see the `watch_for_*` methods on {Queue}.

Finally, run the queue:

    queue.run

This will loop infinitely, calling the appropriate callbacks when the events are fired.
If you don't want infinite looping,
you can also block until there are available events,
process them all at once,
and then continue on your merry way:

    queue.process

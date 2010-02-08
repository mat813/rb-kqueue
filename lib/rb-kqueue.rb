require 'rb-kqueue/native'
require 'rb-kqueue/native/flags'
require 'rb-kqueue/watcher'
require 'rb-kqueue/watcher/vnode'
require 'rb-kqueue/watcher/read_write'
require 'rb-kqueue/watcher/process'
require 'rb-kqueue/event'
require 'rb-kqueue/queue'

module KQueue
  def self.handle_error(errno = FFI.errno)
    raise SystemCallError.new(
      "KQueue failed" +
      case errno
      when Errno::EFAULT::Errno; ": There was an error reading or writing the kevent structure."
      when Errno::EBADF::Errno; ": The specified descriptor is invalid."
      when Errno::EINTR::Errno; ": A signal was delivered before the timeout expired and before any events were placed on the kqueue for return."
      when Errno::EINVAL::Errno; ": The specified time limit or filter is invalid."
      when Errno::ENOENT::Errno; ": The event could not be found to be modified or deleted."
      when Errno::ENOMEM::Errno; ": No memory was available to register the event."
      when Errno::ESRCH::Errno; ": The specified process to attach to does not exist."
      else; ""
      end,
      errno)
  end
end

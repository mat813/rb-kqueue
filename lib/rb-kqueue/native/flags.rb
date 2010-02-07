module KQueue
  module Native
    module Flags
      # Filters
      EVFILT_READ = -1
      EVFILT_WRITE = -2
      EVFILT_AIO = -3 # Attached to aio requests
      EVFILT_VNODE = -4 # Attached to vnodes
      EVFILT_PROC = -5 # Attached to struct proc
      EVFILT_SIGNAL = -6 # Attached to struct proc
      EVFILT_TIMER = -7 # Timers
      EVFILT_MACHPORT = -8 # Mach portsets
      EVFILT_FS = -9 # Filesystem events
      EVFILT_USER = -10 # User events
      EVFILT_SESSION = -11 # Audit session events


      # Actions
      EV_ADD = 0x0001 # Add event to kq (implies enable)
      EV_DELETE = 0x0002 # Delete event from kq
      EV_ENABLE = 0x0004 # Enable event
      EV_DISABLE = 0x0008 # Disable event (not reported)
      EV_RECEIPT = 0x0040 # Force EV_ERROR on success, data == 0

      # Flags
      EV_ONESHOT = 0x0010 # Only report one occurrence
      EV_CLEAR = 0x0020 # Clear event state after reporting
      EV_DISPATCH = 0x0080 # Disable event after reporting

      # Returned values
      EV_EOF = 0x8000 # EOF detected
      EV_ERROR = 0x4000 # Error, data contains errno


      # For EVFILT_VNODE
      NOTE_DELETE = 0x00000001 # Vnode was removed
      NOTE_WRITE = 0x00000002 # Data contents changed
      NOTE_EXTEND = 0x00000004 # Size increased
      NOTE_ATTRIB = 0x00000008 # Attributes changed
      NOTE_LINK = 0x00000010 # Link count changed
      NOTE_RENAME = 0x00000020 # Vnode was renamed
      NOTE_REVOKE = 0x00000040 # Vnode access was revoked
      NOTE_NONE = 0x00000080 # No specific vnode event: to test for EVFILT_READ activation


      # Converts a list of flags to the bitmask that the C API expects.
      #
      # @param prefix [String] The prefix for the C names of the flags
      # @param flags [Array<Symbol>]
      # @return [Fixnum]
      def self.to_mask(prefix, flags)
        flags.map {|flag| const_get("#{prefix}_#{flag.to_s.upcase}")}.
          inject(0) {|mask, flag| mask | flag}
      end

      # Converts a bitmask from the C API into a list of flags.
      #
      # @param prefix [String] The prefix for the C names of the flags
      # @param mask [Fixnum]
      # @return [Array<Symbol>]
      def self.from_mask(prefix, mask)
        re = /^#{Regexp.quote prefix}_/
        constants.select do |c|
          next false unless c =~ re
          const_get(c) & mask != 0
        end.map {|c| c.sub("#{prefix}_", "").downcase.to_sym} - [:all_events]
      end
    end
  end
end

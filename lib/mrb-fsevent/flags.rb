# -*- encoding: utf-8 -*-

module FSEvent
  module Flags
    CREATE = {
      :none =>                    KFSEventStreamCreateFlagNone,
      :useCoreFoundationTypes =>  KFSEventStreamCreateFlagUseCFTypes,
      :noDefer =>                 KFSEventStreamCreateFlagNoDefer,
      :watchRoot =>               KFSEventStreamCreateFlagWatchRoot,
      :ignoreSelf =>              KFSEventStreamCreateFlagIgnoreSelf,
      :fileEvents =>              KFSEventStreamCreateFlagFileEvents
    }.freeze
    
    EVENT = {
      :none =>                    KFSEventStreamEventFlagNone,
      :mustScanSubDirs =>         KFSEventStreamEventFlagMustScanSubDirs,
      :userDropped =>             KFSEventStreamEventFlagUserDropped,
      :kernelDropped =>           KFSEventStreamEventFlagKernelDropped,
      :historyDone =>             KFSEventStreamEventFlagHistoryDone,
      :rootChanged =>             KFSEventStreamEventFlagRootChanged,
      :mount =>                   KFSEventStreamEventFlagMount,
      :unmount =>                 KFSEventStreamEventFlagUnmount,
      :itemCreated =>             KFSEventStreamEventFlagItemCreated,
      :itemRemoved =>             KFSEventStreamEventFlagItemRemoved,
      :itemMetadataModified =>    KFSEventStreamEventFlagItemInodeMetaMod,
      :itemRenamed =>             KFSEventStreamEventFlagItemRenamed,
      :itemModified =>            KFSEventStreamEventFlagItemModified,
      :itemFinderInfoModified =>  KFSEventStreamEventFlagItemFinderInfoMod,
      :itemChangedOwner =>        KFSEventStreamEventFlagItemChangeOwner,
      :itemXattrModified =>       KFSEventStreamEventFlagItemXattrMod,
      :itemIsFile =>              KFSEventStreamEventFlagItemIsFile,
      :itemIsDirectory =>         KFSEventStreamEventFlagItemIsDir,
      :itemIsSymlink =>           KFSEventStreamEventFlagItemIsSymlink
    }.freeze
    
    # more readable than a magic number, but barely
    # this ORs together all file events and then NOTs the result
    # i figure it's safer to blacklist than whitelist
    NOT_FILE_EVENT = ~( KFSEventStreamEventFlagItemCreated |
                        KFSEventStreamEventFlagItemRemoved |
                        KFSEventStreamEventFlagItemInodeMetaMod |
                        KFSEventStreamEventFlagItemRenamed |
                        KFSEventStreamEventFlagItemModified |
                        KFSEventStreamEventFlagItemFinderInfoMod |
                        KFSEventStreamEventFlagItemChangeOwner |
                        KFSEventStreamEventFlagItemXattrMod |
                        KFSEventStreamEventFlagItemIsFile |
                        KFSEventStreamEventFlagItemIsDir |
                        KFSEventStreamEventFlagItemIsSymlink)
    
    class << self
      def flags_to_mask(hash, *flags)
        flags.inject(0) {|mask, flag| mask | hash[flag]}
      end

      def create_flags_to_mask(*flags)
        flags_to_mask(CREATE, *flags)
      end

      def event_flags_to_mask(*flags)
        flags_to_mask(EVENT, *flags)
      end

      def mask_to_flags(hash, mask)
        flags = hash.keys.select {|flag| hash[flag] & mask != 0}
        flags << :none if flags.empty?
        flags
      end

      def create_mask_to_flags(mask)
        mask_to_flags(CREATE, mask)
      end

      def event_mask_to_flags(mask)
        mask_to_flags(EVENT, mask)
      end
      
      def event_mask_without_file_events(mask)
        mask & NOT_FILE_EVENT
      end
    end
    
  end
end

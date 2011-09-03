# -*- encoding: utf-8 -*-

def kshim(name, value)
  Object.const_set(name, value) unless Object.const_defined?(name)
end

# ignoring events originating from the current process introduced in 10.6
kshim 'KFSEventStreamCreateFlagIgnoreSelf',       0x00000008

# file-level events introduced in 10.7
kshim 'KFSEventStreamCreateFlagFileEvents',       0x00000010
kshim 'KFSEventStreamEventFlagItemCreated',       0x00000100
kshim 'KFSEventStreamEventFlagItemRemoved',       0x00000200
kshim 'KFSEventStreamEventFlagItemInodeMetaMod',  0x00000400
kshim 'KFSEventStreamEventFlagItemRenamed',       0x00000800
kshim 'KFSEventStreamEventFlagItemModified',      0x00001000
kshim 'KFSEventStreamEventFlagItemFinderInfoMod', 0x00002000
kshim 'KFSEventStreamEventFlagItemChangeOwner',   0x00004000
kshim 'KFSEventStreamEventFlagItemXattrMod',      0x00008000
kshim 'KFSEventStreamEventFlagItemIsFile',        0x00010000
kshim 'KFSEventStreamEventFlagItemIsDir',         0x00020000
kshim 'KFSEventStreamEventFlagItemIsSymlink',     0x00040000

# the rest isn't version specific and should be taken care of by the framework
# line above, but it doesn't hurt to have it here for documentation.
kshim 'KFSEventStreamCreateFlagNone',             0x00000000
kshim 'KFSEventStreamCreateFlagUseCFTypes',       0x00000001
kshim 'KFSEventStreamCreateFlagNoDefer',          0x00000002
kshim 'KFSEventStreamCreateFlagWatchRoot',        0x00000004
kshim 'KFSEventStreamEventFlagNone',              0x00000000
kshim 'KFSEventStreamEventFlagMustScanSubDirs',   0x00000001
kshim 'KFSEventStreamEventFlagUserDropped',       0x00000002
kshim 'KFSEventStreamEventFlagKernelDropped',     0x00000004
kshim 'KFSEventStreamEventFlagEventIdsWrapped',   0x00000008
kshim 'KFSEventStreamEventFlagHistoryDone',       0x00000010
kshim 'KFSEventStreamEventFlagRootChanged',       0x00000020
kshim 'KFSEventStreamEventFlagMount',             0x00000040
kshim 'KFSEventStreamEventFlagUnmount',           0x00000080

undef :kshim

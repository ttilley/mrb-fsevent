# -*- encoding: utf-8 -*-

module FSEvent
  class Notifier
    attr_reader :watchers
    
    def initialize
      @watchers = []
    end
    
    def watch(path, *flags, &callback)
      options = flags.last.respond_to?(:to_hash) ? flags.pop.to_hash : {}      
      watcher = Watcher.new(path, flags, options, &callback)
      @watchers << watcher
      
      self
    end
    
    def run
      @watchers.each {|watcher| watcher.start}
      CFRunLoopRun()
    end
    
  end
end

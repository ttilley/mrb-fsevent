# -*- encoding: utf-8 -*-

module FSEvent
  class EventList
    FORMATS = {}
    
    attr_reader :watcher
    attr_reader :root
    attr_reader :create_mask
    attr_reader :create_flags
    attr_reader :events
    
    def initialize(watcher)
      @watcher = watcher
      @root = watcher.path
      @create_mask = watcher.mask
      @create_flags = watcher.flags
      @events = []
    end
    
    def each
      @events.each {|event| yield event}
    end
    
    def add(path, mask, id)
      unless self.create_flags.include?(:fileEvents)
        # work around an oddity in the file event API where file-level flags
        # get coalesced alongside everything else and are present even when
        # working with directory-level events. as you can imagine, it can be
        # quite confusing to get an event with a directory path and
        # :itemIsFile set.
        mask = ::FSEvent::Flags.event_mask_without_file_events(mask)
      end
      event = Event.new(path, mask, id)
      @events << event
      event
    end
    
    def inspect
      "#<#{self.class} " \
      "root=#{self.root} " \
      "create_mask=#{self.create_mask} " \
      "create_flags=#{self.create_flags.inspect} " \
      "events=#{self.events.inspect}>"
    end
    
    def to_formatted_string(format=:classic)
      if formatter = FORMATS[format]
        if formatter.respond_to?(:call)
          formatter.call(self).to_s
        else
          formatter.new(self).to_s
        end
      else
        inspect
      end
    end
    
    def to_h
      hash = {
        'root' => self.root,
        'create_mask' => self.create_mask,
        'create_flags' => self.create_flags,
        'events' => []
      }
      
      self.events.each do |event|
        hash['events'] << {
          'path' => event.path,
          'mask' => event.mask,
          'flags' => event.flags,
          'id' => event.id
        }
      end
      
      hash
    end
    
  end
end

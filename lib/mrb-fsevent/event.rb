# -*- encoding: utf-8 -*-

module FSEvent
  class Event
    attr_reader :path
    attr_reader :mask
    attr_reader :id
    
    def initialize(path, mask, id)
      @path = path.dup.freeze
      @mask = mask
      @id = id
    end
    
    def flags
      @flags ||= ::FSEvent::Flags.event_mask_to_flags(@mask)
    end
    
    def inspect
      "#<#{self.class} " \
      "id=#{self.id} " \
      "path='#{self.path}' " \
      "mask=#{self.mask} " \
      "flags=#{self.flags.inspect}>"
    end
    
  end
end

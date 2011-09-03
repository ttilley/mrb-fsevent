# -*- encoding: utf-8 -*-

module FSEvent
  module Formatters
    NIW = lambda do |event_list|
      formatted = event_list.events.inject("") do |str, event|
        str += "%d:%d:%s\n" % [event.mask, event.id, event.path]
      end
      formatted += "\n"
      return formatted
    end
  end
  
  EventList::FORMATS[:niw] = Formatters::NIW
end

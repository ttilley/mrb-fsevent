# -*- encoding: utf-8 -*-

module FSEvent
  module Formatters
    CLASSIC = lambda do |event_list|
      formatted = event_list.events.inject("") do |str, event|
        str += "%s:" % [event.path]
      end
      formatted += "\n"
      return formatted
    end
  end
  
  EventList::FORMATS[:classic] = Formatters::CLASSIC
end

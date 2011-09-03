# -*- encoding: utf-8 -*-

require "mrb-fsevent/support/tnetstring"

module FSEvent
  module Formatters
    TNETSTRING = lambda do |event_list|
      return TNetstring.dump(event_list.to_h)
    end
  end
  
  EventList::FORMATS[:tnetstring] = Formatters::TNETSTRING
end

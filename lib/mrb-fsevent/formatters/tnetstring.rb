# -*- encoding: utf-8 -*-

require 'TSITString'
TSITString.setDefaultDataFormat(2)

module FSEvent
  module Formatters
    TNETSTRING = lambda do |event_list|
      return TSITString.dump(event_list.to_h)
    end
  end

  EventList::FORMATS[:tnetstring] = Formatters::TNETSTRING
end

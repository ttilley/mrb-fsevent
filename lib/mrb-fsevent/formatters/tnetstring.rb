# -*- encoding: utf-8 -*-

begin
  require 'tnetstring'
rescue LoadError
  require "mrb-fsevent/support/tnetstring"
end

module FSEvent
  module Formatters
    TNETSTRING = lambda do |event_list|
      return TNetstring.dump(event_list.to_h)
    end
  end
  
  EventList::FORMATS[:tnetstring] = Formatters::TNETSTRING
end

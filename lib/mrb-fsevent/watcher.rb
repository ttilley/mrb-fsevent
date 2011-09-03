# -*- encoding: utf-8 -*-

module FSEvent
  class Watcher
    DEFAULT_FLAGS = [:useCoreFoundationTypes].freeze
    DEFAULT_OPTIONS = {
      :since => KFSEventStreamEventIdSinceNow,
      :latency => 0.5
    }.freeze
    
    CALLBACK = Proc.new do |stream, context, num_events, paths, masks, ids|
      paths = paths.to_object
      context.cast!('@')
      watcher = context[0]
      
      if $DEBUG
        STDERR.puts("\n\n")
        STDERR.puts("FSEventStreamCallback fired!")
        STDERR.puts("number of events: #{num_events}")
        FSEventStreamShow(stream)
      end
      
      events = EventList.new(watcher)
      
      num_events.times do |num|
        event = events.add(paths[num], masks[num], ids[num])
        STDERR.puts("#{event.inspect}") if $DEBUG
      end
      
      watcher.handle(events)
    end
    
    attr_reader :path
    attr_reader :flags
    attr_reader :mask
    
    def initialize(path, flags, options, &callback)
      @pointer = Pointer.new(:object)
      @pointer.assign(self)
      
      @path = path.dup.freeze
      @flags = (DEFAULT_FLAGS + flags).uniq.freeze
      @mask = ::FSEvent::Flags.create_flags_to_mask(*@flags)
      options = DEFAULT_OPTIONS.merge(options)
      @callback = callback
            
      context = FSEventStreamContext.new(0, @pointer, nil, nil, nil)
      @stream = FSEventStreamCreate(KCFAllocatorDefault, CALLBACK,
                                   context, [@path], options[:since],
                                   options[:latency], @mask)
      FSEventStreamScheduleWithRunLoop(@stream, CFRunLoopGetCurrent(),
                                       KCFRunLoopDefaultMode)
    end
    
    def handle(events)
      @callback.call(events)
    end
    
    def start
      return if @started
      FSEventStreamStart(@stream) || raise("failed to start event stream")
      @started = true
    end
    
    def stop
      return unless @started
      FSEventStreamStop(@stream)
      @started = false
    end
    
    def flush
      FSEventStreamFlushSync(@stream)
    end
    
    def flush_async
      FSEventStreamFlushAsync(@stream)
    end
    
    def release
      return unless @stream
      self.stop
      FSEventStreamInvalidate(@stream)
      FSEventStreamRelease(@stream)
      @stream = nil
    end
    
  end
end

# -*- encoding: utf-8 -*-

require 'optparse'

module FSEvent
  module CLI
    OSProductVersion = `sw_vers -productVersion`.strip.split('.').map(&:to_i)
    OSMajorVersion, OSMinorVersion, OSBugFixVersion = OSProductVersion
    
    def parse(args)
      options = {
        :since => KFSEventStreamEventIdSinceNow,
        :latency => 0.5,
        :no_defer => false,
        :watch_root => false,
        :ignore_self => false,
        :file_events => false,
        :format => :classic,
        :debug => false
      }
      
      op = OptionParser.new do |opts|
        opts.banner = "Usage: fsevent_watch [options] [paths]"
        opts.separator ""

        opts.on("--since-when EventID", Integer,
                "fire historical events since EventID") do |eventid|
          options[:since] = eventid
        end

        opts.on("--latency Seconds", Float, "latency period") do |latency|
          options[:latency] = latency
        end

        opts.on("--[no-]defer",
                "no-defer latency modifier") do |defer|
          options[:no_defer] = !defer
        end

        opts.on("--[no-]watch-root",
                "watch the root path for changes") do |watch_root|
          options[:watch_root] = watch_root
        end

        opts.on("--[no-]ignore-self",
                "ignore the current process") do |ignore_self|
          if ((OSMajorVersion == 10) && (OSMinorVersion >= 6))
            options[:ignore_self] = ignore_self
          else
            STDERR.puts("--ignore-self needs 10.6+")
          end
        end

        opts.on("--[no-]file-events",
                "provide file level event data") do |file_events|
          if ((OSMajorVersion == 10) && (OSMinorVersion >= 7))
            options[:file_events] = file_events
          else
            STDERR.puts("--file-events needs 10.7+")
          end
        end

        opts.on("--[no-]debug", "output debugging info") do |debug|
          options[:debug] = debug
        end

        opts.on("--format format", ::FSEvent::EventList::FORMATS.keys,
                "select output format") do |format|
          options[:format] = format
        end
      end
      
      # paths = op.parse!(args)
      # paths = ['.'] if paths.empty?
      # paths.map! { |path| File.expand_path path }
      # paths.map! { |path| path.sub(/^\/private/, '') }
      # options[:paths] = paths
      
      paths = op.parse!(args)
      paths << '.' if paths.empty?
      options[:urls] = paths.map do |path|
        NSURL.fileURLWithPath(path.stringByStandardizingPath)
      end
      
      create_flags = [:useCoreFoundationTypes]
      create_flags << :noDefer if options[:no_defer]
      create_flags << :watchRoot if options[:watch_root]
      create_flags << :ignoreSelf if options[:ignore_self]
      create_flags << :fileEvents if options[:file_events]
      options[:create_flags] = create_flags
      
      options
    end
    
    module_function :parse
    
  end
end

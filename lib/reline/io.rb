
module Reline
  class IO
    def self.decide_io_gate
      if ENV['TERM'] == 'dumb'
        Reline::Dumb.new
      else
        require 'reline/io/ansi'

        case RbConfig::CONFIG['host_os']
        when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
          require 'reline/io/windows'
          io = Reline::Windows.new
          if io.msys_tty?
            Reline::ANSI.new
          else
            io
          end
        else
          if $stdout.tty?
            Reline::ANSI.new
          else
            Reline::Dumb.new
          end
        end
      end
    end

    def dumb?
      false
    end

    def win?
      false
    end
  end
end

require 'reline/io/dumb'

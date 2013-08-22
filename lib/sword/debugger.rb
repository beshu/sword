module Sword
  module Debugger
    def debug(*messages)
      $stderr.print(*messages) if Environment.debug
    end

    def sdebug(*messages)
      messages.map! { |m| '   ' << m.to_s }
      debug(*messages)
    end

    def debugln(*messages)
      $stderr.puts(*messages) if Environment.debug
    end

    def sdebugln(*messages)
      messages.map! { |m| '   ' << m.to_s }
      debugln(*messages)
    end

    def puts(*messages)
      $stderr.puts(*messages) unless Environment.silent
    end

    def print(*messages)
      $stderr.print(*messages) unless Environment.silent
    end
  end
end

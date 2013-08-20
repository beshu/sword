module Sword
  module Debugger
    def debug(*messages)
      print(*messages) if Environment.debug
    end

    def debugln(*messages)
      puts(*messages) if Environment.debug
    end

    def puts(*messages)
      $stderr.puts(*messages) unless Environment.silent
    end

    def print(*messages)
      $stderr.print(*messages) unless Environment.silent
    end
  end
end

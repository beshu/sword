module Sword
  module Debugger
    def debug(message)
      print message if Environment.debug
    end

    def debugln(message)
      puts message if Environment.debug
    end

    def puts(*args)
      $stderr.puts(*args) unless Environment.silent
    end

    def print(*args)
      $stderr.print(*args) unless Environment.silent
    end
  end
end

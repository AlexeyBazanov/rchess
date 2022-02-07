require 'color-console'

class ConsoleRenderer
  def render(string)
    write string
  end

  protected

  def write(string, color=:white)
    Console.puts string, color
  end
end
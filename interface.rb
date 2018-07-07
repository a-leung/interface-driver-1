class FileDriver
  @file

  def initialize(file_name)
    @file = File.open(file_name, "wb")
  end

  def write(text)
    @file.write(text)
  end

  def read(file_name = "user_input.txt")
    screen = ScreenDriver.new
    screen.write("reading from #{file_name} file")
    screen.write(File.read(file_name))
  end

  def close
    @file.close
  end

end

class ScreenDriver

  def iniitialize
  end

  def write(text)
    puts text
  end

  def read
    puts "type in some input for the ScreenDriver"
    puts "the input received is: " + STDIN.gets
  end

  def close
  end
end

class UserInterface
  @interface

  def initialize(options)
    @interface = case options
                 when :screen
                   ScreenDriver.new
                 when :file
                   FileDriver.new("file_driver_test.txt")
                 when :html
                   HTMLDriver.new
                 when :test
                   TestDriver.new
                 else
                   raise ArgumentError
                   exit 0
                 end
  end

  def write(text)
    @interface.write(text)
  end

  def read
    @interface.write("getting input")
    @interface.read
  end

  def close
    @interface.close
  end
end

class HTMLDriver
  def initialize(html_filename = "interface.html")
    @file = File.open(html_filename, "wb")
    @file.write("<html>\n<body>\n")
  end

  def write(text)
    @file.write("<p>\n")
    @file.write(text)
    @file.write("</p>\n")
  end

  def read
    raise FunctionError
  end

  def close
    @file.write("\n</body>\n</html>")
    @file.close
  end
end

screen_interface = UserInterface.new(:screen)
screen_interface.write("screen test")
screen_interface.read
screen_interface.close

file_interface = UserInterface.new(:file)
file_interface.write("file test")
file_interface.read
file_interface.close

html_interface = UserInterface.new(:html)
html_interface.write("writing to html file now")
html_interface.close

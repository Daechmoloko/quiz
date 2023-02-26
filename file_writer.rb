class FileWriter 

  def initialize(mode, options = {})
    @filename = "QUIZ #{options[:name]}_#{options[:current_time]}.txt"
    @mode = mode
  end

  def write(content)
    File.write(
      @filename,
      content,
      mode: @mode
    )
  end
end
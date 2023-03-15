# frozen_string_literal: true

class FileWriter
  def call(mode, content, *args)
    File.open("QUIZ #{args.first}_#{args.last}.txt", mode) do |f|
      f.write(
        content
      )
    end
  end
end

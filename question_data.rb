class QuestionData 
  require 'yaml'
  require_relative 'question'

  attr_reader :collection

  def initialize(filename = 'question.yml', writer)
    @collection = load_from filename
    @writer = writer
    @writer.write("\n\n*** #{@collection.inspect} ***\n\n")
  end

  private

  def load_from(filename)
    YAML.safe_load_file(filename, symbolize_names: true).shuffle.map do |q_data|
      Question.new(q_data[:question], q_data[:answers])
    end
  end
end
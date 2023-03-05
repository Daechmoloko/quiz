class QuestionData 
  require 'yaml'
  require_relative 'question'

  attr_reader :collection

  def initialize(filename = 'question.yml', name_quiz)
    @collection = load_from(filename, name_quiz)
  end

  private

  def load_from(filename, name_quiz)
    YAML.safe_load_file(filename, symbolize_names: true).select {|arg| arg[:name] == name_quiz}.
    last[:question].shuffle.map do |q_data|
      Question.new(q_data[:title], q_data[:answers])
    end
  end
end

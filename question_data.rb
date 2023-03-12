class QuestionData
  require 'yaml'
  require_relative 'question'

  def call(filename = 'question.yml', name_quiz)
    load_from(filename, name_quiz)
  end

  def load_from(filename, name_quiz)
    YAML.safe_load_file(filename, symbolize_names: true).select { |arg| arg[:name] == name_quiz }
        .last[:question].shuffle.map do |q_data|
      Question.new.call(q_data[:title], q_data[:answers])
    end
  end
end

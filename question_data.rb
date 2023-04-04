# frozen_string_literal: true

class QuestionData
  require_relative 'question'

  def call(quiz_contract, name_quiz)
    load_from(quiz_contract, name_quiz)
  end

  def load_from(quiz_contract, name_quiz)
    quiz_contract.select { |arg| arg[:name] == name_quiz }
                 .last[:question].shuffle.map do |q_data|
      Question.new.call(q_data[:title], q_data[:answers])
    end
  end
end

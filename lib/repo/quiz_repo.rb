# frozen_string_literal: true

require 'rom-repository'

class QuizRepo < ROM::Repository[:quizzes]
  def by_id_quiz(name_quiz)
    quizzes.where(name_quiz).to_a
  end
end

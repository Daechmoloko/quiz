# frozen_string_literal: true

require 'rom-repository'

class ResultRepo < ROM::Repository[:results]
  commands :create
end

class AnswerRepo < ROM::Repository[:answers]
  def query_answer(id)
    answers.where(id).to_a
  end
end

class QuestionRepo < ROM::Repository[:questions]
  def query_question(id)
    questions.where(id).to_a
  end
end

class QuizRepo < ROM::Repository[:quizzes]
  def by_id_quiz(name_quiz)
    quizzes.where(name_quiz).one!.to_h
  end
end

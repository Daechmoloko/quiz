# frozen_string_literal: true

require 'rom-repository'

class AnswerRepo < ROM::Repository[:answers]
  def query_answer(id)
    answers.where(id).to_a
  end
end

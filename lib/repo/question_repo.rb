# frozen_string_literal: true

require 'rom-repository'

class QuestionRepo < ROM::Repository[:questions]
  def query_question(id)
    questions.where(id).to_a
  end
end


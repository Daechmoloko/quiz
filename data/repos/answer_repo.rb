# frozen_string_literal: true

require 'rom-repository'

module Repos
  class AnswerRepo < ROM::Repository[:answers]
    def query_answer(id)
      answers.where(id).to_a
    end
  end
end

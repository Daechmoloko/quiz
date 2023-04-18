require 'rom-repository'

module Repos
  class QuestionRepo < ROM::Repository[:questions]
    def query_question(id)
      questions.where(id).to_a
    end
  end
end
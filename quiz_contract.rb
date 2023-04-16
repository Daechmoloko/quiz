# frozen_string_literal: true

# class QuizContract < Dry::Validation::Contract
#   schema do
#     required(:config).array(:hash) do
#       required(:name).filled(:string)
#       required(:question).array(:hash) do
#         required(:title).filled(:string)
#         required(:answers).filled(:array)
#       end
#     end
#   end
# end

class QuizNameContract < Dry::Validation::Contract
  schema do
    required(:id).value(:integer)
    required(:name).value(:string)
  end
end

# frozen_string_literal: true

require 'dry/validation'
require 'rom'
require 'pry'
require_relative 'question'
require_relative 'data/repo/result_repo'

class QuestionData
  def call(rom, id_quiz)
    load_from(rom, id_quiz)
  end

  def instantiated_question_repo(rom)
    QuestionRepo.new(rom)
  end

  def instantiated_answer_repo(rom)
    AnswerRepo.new(rom)
  end

  def load_from(rom, id_quiz)
    load_from_question_answer_db(rom, id_quiz).shuffle.map do |q_data|
      Question.new.call(q_data[:title], q_data[:answers])
    end
  end

  def load_from_question_answer_db(rom, id_quiz)
    instantiated_question_repo(rom).query_question(id_quiz: id_quiz).map do |q_data|
      content = {}
      content[:title] = q_data.body
      content[:answers] = instantiated_answer_repo(rom).query_answer(id_question: q_data.id_question).map(&:body)
      content
    end
  end
end

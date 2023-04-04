# frozen_string_literal: true

require 'time'
require_relative 'question_data'
require_relative 'statistiks'
require_relative 'questions_with_answers'
require_relative 'data/repo/result_repo'


class Run
  def name_user
    puts 'Введите Ваше имя'
    $stdin.gets.strip
  end

  def transit_time
    Time.now.strftime('%Y-%m-%d_%H:%M:%S')
  end

  def raw_question_data
    QuestionData.new
  end

  def entry_report_statistik
    Statistiks.new
  end

  def input_question_and_answers
    QuestionWithAnswers.new
  end

  def instantiated_repo(rom)
    ResultRepo.new(rom)
  end

  def call(name_quiz, quiz_contract, rom)
    name = name_user
    current_time = transit_time
    result = []
    question_data = raw_question_data
    statistiks = entry_report_statistik
    input_question_and_answers.call(question_data, statistiks, name_quiz, quiz_contract, result)
    corrent_answer_percentage = statistiks.call(name, current_time, result)
    instantiated_repo(rom).create(name: name, time: current_time, result: corrent_answer_percentage)
  end
end

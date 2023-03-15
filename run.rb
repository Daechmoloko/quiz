# frozen_string_literal: true

require 'time'
require_relative 'question_data'
require_relative 'file_writer'
require_relative 'statistiks'
require_relative 'questions_with_answers'
class Run
  def name_user
    puts 'Введите Ваше имя'
    $stdin.gets.strip
  end

  def transit_time
    Time.now.strftime('%Y-%m-%d_%H:%M:%S')
  end

  def create_report_file
    FileWriter.new
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

  def call(name_quiz, quiz_contract)
    name = name_user
    current_time = transit_time
    writer = create_report_file
    writer.call('a', "\n\n*** Имя пользователя #{name} ***\n", name, current_time)
    writer.call('a', "\n\n*** Названия квиза #{name_quiz} ***\n", name, current_time)
    writer.call('a', "\n\n*** Время создания #{current_time} ***\n\n", name, current_time)
    question_data = raw_question_data
    statistiks = entry_report_statistik
    result = []
    input_question_and_answers.call(question_data, statistiks, name_quiz, quiz_contract, result)
    statistiks.call(name, current_time, writer, result)
  end
end

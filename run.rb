require 'time'
require_relative 'question_data'
require_relative 'file_writer'
require_relative 'statistiks'

class Run
  def get_name
    puts 'Введите Ваше имя'
    STDIN.gets.strip
  end

  def get_current_time
    Time.now.strftime('%Y-%m-%d_%H:%M:%S')
  end

  def create_report_file
    FileWriter.new
  end

  def get_raw_question_data
    QuestionData.new
  end

  def entry_report_statistik
    Statistiks.new
  end

  def question_answers(question_data, statistiks, name_quiz, result)
    question_data.call(name_quiz).each do |next_question|
      display_question(next_question.first[:body])
      display_answers(next_question.first[:answers])
      user_answer = next_question.first[:answers][ask_for_answer_char]
      check?(user_answer, next_question.first[:corrent_answer], statistiks, result)
      result
    end
  end

  def display_answers(answers)
    answers.each do |char, text|
      puts "#{char}. #{text}"
    end
  end

  def display_question(body)
    puts "\n\n *** #{body} *** \n\n"
  end

  def ask_for_answer_char
    loop do
      puts 'Ваш ответ: '
      user_answer_char = STDIN.gets.strip
      if user_answer_char.empty?
        puts 'Ответ не должен быть пустым!'
        next
      elsif !user_answer_char.upcase[0].between?('A', 'D')
        return user_answer_char
      else
        puts 'Ответ должен быть от А до D'
      end
    end
  end

  def check?(user_answer, corrent_answer, statistiks, result)
    if user_answer == corrent_answer
      puts 'Верно!'
      statistiks.counter_answers(result, 1)
      result
    else
      puts 'Неверно!'
      puts "Верный ответ #{corrent_answer}"
      statistiks.counter_answers(result, 0)
      result
    end
  end

  def call(name_quiz, **)
    name = get_name
    current_time = get_current_time
    writer = create_report_file
    writer.call('a', "\n\n*** Имя пользователя #{name} ***\n", name, current_time)
    writer.call('a', "\n\n*** Названия квиза #{name_quiz} ***\n", name, current_time)
    writer.call('a', "\n\n*** Время создания #{current_time} ***\n\n", name, current_time)
    question_data = get_raw_question_data
    statistiks = entry_report_statistik
    result = []
    question_answers(question_data, statistiks, name_quiz, result)
    statistiks.call(name, current_time, writer, result)
  end
end

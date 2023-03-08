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

  def question_answers(question_data, statistiks, name_quiz)
    question_data.collection(name_quiz).each do |next_question|
      puts next_question
      next_question.display_answers
      user_answer = next_question.find_answer_by(ask_for_answer_char)

      check?(user_answer, next_question.corrent_answer, statistiks)
    end
  end

  def ask_for_answer_char
    loop do
      puts 'Ваш ответ: '
      user_answer_char = STDIN.gets.strip[0]
      return user_answer_char if !user_answer_char.nil? && user_answer_char.upcase.between?('A', 'D')

      puts 'Ответ должен быть от А до D, и не пустым!'
    end
  end

  def check?(user_answer, corrent_answer, statistiks)
    if user_answer == corrent_answer
      puts 'Верно!'
      statistiks.corrent
    else
      puts 'Неверно!'
      puts "Верный ответ #{corrent_answer}"
      statistiks.incorrent
    end
  end

  def call(name_quiz, **)
    name = get_name
    current_time = get_current_time
    writer = create_report_file
    writer.write('a', "\n\n*** Имя пользователя #{name} ***\n", name, current_time)
    writer.write('a', "\n\n*** Названия квиза #{name_quiz} ***\n", name, current_time)
    writer.write('a', "\n\n*** Время создания #{current_time} ***\n\n", name, current_time)
    question_data = get_raw_question_data
    statistiks = entry_report_statistik
    question_answers(question_data, statistiks, name_quiz)
    statistiks.print_report(name, current_time, writer)
  end
end

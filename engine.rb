require_relative 'question_data'
require_relative 'file_writer'
require_relative 'statistiks'

class Engine 
  
  def initialize
    
    puts "Введите Ваше имя"
    name = gets.strip 
    current_time = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
    
    @writer = FileWriter.new('a', {name: name, current_time: current_time})
    @question_data = QuestionData.new @writer

    @writer.write("Результаты для пользователя #{name} - #{current_time}\n\n")

    @statistiks = Statistiks.new @writer
  end

  def run 
    @question_data.collection.each do |next_question|
      puts next_question #to_s
      #@write.write(next_question)
      next_question.display_answers
      user_answer = next_question.find_answer_by(ask_for_answer_char)
      #@writer.write("Ответ пользователя #{user_answer}\n\n")

      check?(user_answer, next_question.corrent_answer)
    end

    @statistiks.print_report
  end

  private

  def ask_for_answer_char 
    loop do
      puts "Ваш ответ: "
      user_answer_char = gets.strip[0].upcase
      return user_answer_char if user_answer_char.between?('A', 'D')

      puts "Ответ должен быть от А до D!"
    end
  end

  def check?(user_answer, corrent_answer)
    if user_answer == corrent_answer
      puts "Верно!"
      @statistiks.corrent 
    else
      puts "Неверно!"
      puts "Верный ответ #{corrent_answer}"
      @statistiks.incorrent 
    end
  end
end
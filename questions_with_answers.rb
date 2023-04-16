# frozen_string_literal: true

class QuestionWithAnswers
  def call(question_data, statistiks, result, rom, quiz_contract)
    question_data.call(rom, quiz_contract).each do |next_question|
      display_question(next_question.first[:body])
      display_answers(next_question.first[:answers])
      user_answer = next_question.first[:answers][ask_for_answer_char]
      check?(user_answer, next_question.first[:corrent_answer], statistiks, result)
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
      user_answer_char = $stdin.gets.strip
      if user_answer_char.empty?
        puts 'Ответ не должен быть пустым!'
        next
      elsif user_answer_char.upcase[0].between?('A', 'D')
        return user_answer_char.upcase
      else
        puts 'Ответ должен быть от А до D'
      end
    end
  end

  def check?(user_answer, corrent_answer, statistiks, result)
    if user_answer == corrent_answer
      puts 'Верно!'
      statistiks.counter_answers(result, 1)
    else
      puts 'Неверно!'
      puts "Верный ответ #{corrent_answer}"
      statistiks.counter_answers(result, 0)
    end
  end
end

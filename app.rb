#!/usr/bin/env ruby
require "bundler/setup"
require "dry/cli"
require "time"


module App 
  module CLI 
    module Commands 
      extend Dry::CLI::Registry

      class RunQuiz < Dry::CLI::Command
  
        def call(*)
          Generate::Run.new().call
        end

      end
    
      module Generate  
        require_relative "question_data"
        require_relative "file_writer"
        require_relative "statistiks"

        class Run < Dry::CLI::Command
          
          def call(*)

            puts "Введите Ваше имя"
            name = STDIN.gets.strip
            current_time = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
            @writer = FileWriter.new('a', {name: name, current_time: current_time})
            @question_data = QuestionData.new @writer
            @statistiks = Statistiks.new @writer

            @question_data.collection.each do |next_question|
              puts next_question
              next_question.display_answers
              user_answer = next_question.find_answer_by(ask_for_answer_char )
        
              check?(user_answer, next_question.corrent_answer)
            end

            @statistiks.print_report
          end

          private

          def ask_for_answer_char 
            loop do
              puts "Ваш ответ: "
              user_answer_char = STDIN.gets.strip[0].upcase
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
      end
      
      register "run_quiz", RunQuiz

    end
  end
end

Dry::CLI.new(App::CLI::Commands).call

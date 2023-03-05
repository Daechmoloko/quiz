#!/usr/bin/env ruby
require "bundler/setup"
require "dry/cli"
require "time"
require_relative "question_data"
require_relative "file_writer"
require_relative "statistiks"


module App 
  module CLI 
    module Commands 
      extend Dry::CLI::Registry

      class RunQuiz < Dry::CLI::Command

        desc "Print name quiz"

        argument :name_quiz, desc: "Название квиза"

        example [
          "             # Prints name quiz"
        ]
  
        def call(name_quiz: 'first_quiz', **)
          Generate::Run.new.call(name_quiz)
        end

      end
    
      module Generate 

        class Run <Dry::CLI::Command

         

          def get_name
            puts "Введите Ваше имя"
            STDIN.gets.strip 
          end

          def get_current_time
            Time.now.strftime("%Y-%m-%d_%H:%M:%S")
          end
          
          def create_report_file(name, current_time)
            FileWriter.new('a', {name: name, current_time: current_time})
          end

          def get_raw_question_data(name_quiz) 
            QuestionData.new name_quiz
          end

          def entry_report_statistik (writer)
            Statistiks.new writer
          end

          def question_answers(question_data, statistiks)
            question_data.collection.each do |next_question|
              puts next_question
              next_question.display_answers
              user_answer = next_question.find_answer_by(ask_for_answer_char )
        
              check?(user_answer, next_question.corrent_answer, statistiks)
            end
          end

          def ask_for_answer_char 
            loop do
              puts "Ваш ответ: "
              user_answer_char = STDIN.gets.strip[0]
              return user_answer_char if !user_answer_char.nil? && user_answer_char.upcase.between?('A', 'D')

              puts "Ответ должен быть от А до D, и не пустым!"
            end
          end

          def check?(user_answer, corrent_answer, statistiks)
            if user_answer == corrent_answer
              puts "Верно!"
              statistiks.corrent 
            else
              puts "Неверно!"
              puts "Верный ответ #{corrent_answer}"
              statistiks.incorrent 
            end
          end

          def call(name_quiz, **)
            name = get_name
            current_time = get_current_time
            writer = create_report_file(name, current_time)
            writer.write("\n\n*** Имя пользователя #{name} ***\n")
            writer.write("\n\n*** Названия квиза #{name_quiz} ***\n")
            writer.write("\n\n*** Время создания #{current_time} ***\n\n")
            question_data = get_raw_question_data(name_quiz)
            statistiks = entry_report_statistik(writer)
            question_answers(question_data, statistiks)
            statistiks.print_report
          end
        end
      end
      
      register "run_quiz", RunQuiz

    end
  end
end

Dry::CLI.new(App::CLI::Commands).call

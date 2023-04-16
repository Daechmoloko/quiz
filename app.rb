#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'yaml'
require 'dry/cli'
require 'dry/validation'
require 'rom'
require 'pry'
require_relative 'run'
require_relative 'quiz_contract'

module App
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class RunQuiz < Dry::CLI::Command
        desc 'Print name quiz'

        argument :name_quiz, desc: 'Название квиза'

        example [
          '             # Prints name quiz'
        ]
        def connected_db
          ROM.container(:sql, 'sqlite://data/database_result.DB') do |conf|
            conf.relation(:results) do
              schema(infer: true)
              auto_struct true
            end
            conf.relation(:answers) do
              schema(infer: true)
              auto_struct true
            end
            conf.relation(:questions) do
              schema(infer: true)
              auto_struct true
            end
            conf.relation(:quizzes) do
              schema(infer: true)
              auto_struct true
            end
          end
        end

        def instantiated_quiz_repo(rom)
          QuizRepo.new(rom)
        end

        def load_quiz_from_db(rom, name_quiz)
          quiz = instantiated_quiz_repo(rom).by_id_quiz(name: name_quiz)
          QuizNameContract.new.call(quiz)
        end

        def call(name_quiz:, **)
          rom = connected_db
          contract_quiz = load_quiz_from_db(rom, name_quiz)
          if contract_quiz.success?
            puts 'Contract valid'
            Run.new.call(contract_quiz[:name].freeze, contract_quiz[:id].freeze, rom)
          else
            puts 'Contract not valid'
          end
        end
      end

      register 'run_quiz', RunQuiz
    end
  end
end

Dry::CLI.new(App::CLI::Commands).call

#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'yaml'
require 'dry/cli'
require 'dry/validation'
require 'rom'
require 'pry'
require_relative 'system/boot'
require_relative 'run'

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

        def instantiated_quiz_repo(rom)
          QuizRepo.new(rom)
        end

        def load_quiz_from_db(rom, name_quiz)
          instantiated_quiz_repo(rom).by_id_quiz(name: name_quiz)
        end

        def call(name_quiz:, **)
          # rom = connected_db
          rom = Application['connected']
          binding.pry
          contract_quiz = load_quiz_from_db(rom, name_quiz)
          Run.new.call(contract_quiz.first.name, contract_quiz.first.id, rom)
        end
      end

      register 'run_quiz', RunQuiz
    end
  end
end

Dry::CLI.new(App::CLI::Commands).call

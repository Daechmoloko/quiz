#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'yaml'
require 'dry/cli'
require_relative 'run'
require 'dry/validation'
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

        def call(name_quiz: 'first_quiz', filename: "question.yml", **)
          config = QuizContract.new().call(YAML.safe_load_file(filename, symbolize_names: true))
          if config.success?
            puts "Contract valid"
            Run.new.call(name_quiz)
          else
            puts "Contract not valid"
          end
        end
      end

      register 'run_quiz', RunQuiz
    end
  end
end

Dry::CLI.new(App::CLI::Commands).call

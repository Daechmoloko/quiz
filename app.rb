#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'yaml'
require 'dry/cli'
require 'dry/validation'
require 'rom'
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
          end
        end

        def call(name_quiz:, filename: 'question.yml', **)
          contract = QuizContract.new.call(YAML.safe_load_file(filename, symbolize_names: true))
          if contract.success?
            puts 'Contract valid'
            rom = connected_db
            Run.new.call(name_quiz, contract[:config].freeze, rom)
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

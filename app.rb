#!/usr/bin/env ruby
require 'bundler/setup'
require 'dry/cli'
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

        def call(name_quiz: 'first_quiz', **)
          Run.new.call(name_quiz)
        end
      end

      register 'run_quiz', RunQuiz
    end
  end
end

Dry::CLI.new(App::CLI::Commands).call

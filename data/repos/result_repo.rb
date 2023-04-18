# frozen_string_literal: true
require 'rom-repository'

module Repos
  class ResultRepo < ROM::Repository[:results]
    commands :create
  end
end
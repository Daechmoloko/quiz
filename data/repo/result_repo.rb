require 'rom-repository'

class ResultRepo < ROM::Repository[:results]
  commands :create
end


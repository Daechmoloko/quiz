# frozen_string_literal: true

class Statistiks
  def counter_answers(arr, index)
    arr << index
  end

  def call(_name, _current_time, result)
    corrent_answer = result.select { |i| i == 1 }.size
    incorrent_answer = result.select(&:zero?).size
    ((corrent_answer / (corrent_answer + incorrent_answer).to_f) * 100).floor
  end
end

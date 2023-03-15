# frozen_string_literal: true

class Statistiks
  def counter_answers(arr, index)
    arr << index
  end

  def call(name, current_time, writer, result)
    corrent_answer = result.select { |i| i == 1 }.size
    incorrent_answer = result.select(&:zero?).size
    writer.call('a', "Кол-во правильных ответов - #{corrent_answer}\n\n", name, current_time)
    writer.call('a', "Кол-во неправильных ответов - #{incorrent_answer}\n\n", name, current_time)

    corrent_answer_percentage = ((corrent_answer / (corrent_answer + incorrent_answer).to_f) * 100).floor

    writer.call('a', "Процент правильных ответ - #{corrent_answer_percentage}\n\n", name, current_time)
  end
end

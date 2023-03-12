class Question
  FIRST_ANSWER_CODE = 'A'.ord

  def populate_answers_from(raw_answers)
    raw_answers.shuffle.each_with_index.each_with_object({}) do |(answer, i), result|
      answer_char = (FIRST_ANSWER_CODE + i).chr
      result[answer_char] = answer
    end
  end

  def call(question_text, raw_answers)
    rezult = []
    rezult << { body: question_text, corrent_answer: raw_answers.first, answers: populate_answers_from(raw_answers) }
  end
end

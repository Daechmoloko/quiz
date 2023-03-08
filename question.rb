class Question
  attr_reader :body, :corrent_answer, :answers

  FIRST_ANSWER_CODE = 'A'.ord

  def initialize(question_text, raw_answers)
    @body = question_text # тело вопроса
    @corrent_answer = raw_answers.first # верный ответ
    @answers = populate_answers_from raw_answers
  end

  def to_s
    "\n\n *** #{body} *** \n\n"
  end

  def display_answers
    @answers.each do |char, text|
      puts "#{char}. #{text}"
    end
  end

  def find_answer_by(char)
    @answers[char]
  end

  private

  def populate_answers_from(raw_answers)
    raw_answers.shuffle.each_with_index.each_with_object({}) do |(answer, i), result|
      answer_char = (FIRST_ANSWER_CODE + i).chr
      result[answer_char] = answer
    end
  end
end

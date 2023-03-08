class Statistiks
  def initialize
    @corrent_answer = 0
    @incorrent_answer = 0
  end

  def corrent
    @corrent_answer += 1
  end

  def incorrent
    @incorrent_answer += 1
  end

  def print_report(name, current_time, writer)
    writer.write('a', "Кол-во правильных ответов - #{@corrent_answer}\n\n", name, current_time)
    writer.write('a', "Кол-во неправильных ответов - #{@incorrent_answer}\n\n", name, current_time)

    corrent_answer_percentage = ((@corrent_answer / (@corrent_answer + @incorrent_answer).to_f) * 100).floor

    writer.write('a', "Процент правильных ответ - #{corrent_answer_percentage}\n\n", name, current_time)
  end
end

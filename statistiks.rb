class Statistiks 
  
  def initialize(writer)
    @corrent_answer = 0
    @incorrent_answer = 0
    @writer = writer
  end

  def corrent 
    @corrent_answer += 1
  end

  def incorrent 
    @incorrent_answer += 1
  end

  def print_report 
    @writer.write("Кол-во правильных ответов - #{@corrent_answer}\n\n")
    @writer.write("Кол-во неправильных ответов - #{@incorrent_answer}\n\n")

    corrent_answer_percentage = ((@corrent_answer / (@corrent_answer + @incorrent_answer).to_f) * 100).floor

    @writer.write("Процент правильных ответ - #{corrent_answer_percentage}\n\n")
  end

end
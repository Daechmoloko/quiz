ROM.container(:sql, 'sqlite://quiz/db/database_result.DB') do |conf|
  conf.relation(:results) do
    schema(infer: true)
    auto_struct true
  end
  conf.relation(:answers) do
    schema(infer: true)
    auto_struct true
  end
  conf.relation(:questions) do
    schema(infer: true)
    auto_struct true
  end
  conf.relation(:quizzes) do
    schema(infer: true)
    auto_struct true
  end
end
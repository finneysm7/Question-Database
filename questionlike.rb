class QuestionLike
  attr_accessor :likes_id, :userid, :questionid
  
  def initialize(options = {})
    @likes_id = options['likes_id']
    @userid = options['userid']
    @questionid = options['questionid']
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        likes_id = ?
    SQL
    results.map { |result| QuestionLike.new(result) }
  end
  
  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.*
      FROM
        question_likes
      JOIN
        users u
      ON 
        u.id = userid
      WHERE
        questionid = ?
    SQL
    results.map { |result| User.new(result) }
  end
  
  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(u.id)
      FROM
        question_likes
      JOIN 
        users u
      ON 
        u.id = userid
      WHERE
        questionid = ?
    SQL
    results[0].values[0]
  end
  
  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        q.*
      FROM
        question_likes
      JOIN
        questions q
      ON 
        q.id = questionid
      WHERE
        userid = ?
    SQL
    results.map { |result| Question.new(result) }
  end
  
  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      q.id, COUNT(ql.userid)
    FROM
      questions q
    JOIN
      question_likes ql
    ON
      q.id = questionid
    GROUP BY
      questionid
    ORDER BY COUNT(ql.userid) DESC
    LIMIT ?
    SQL
    results# .map { |result| Question.new(result) }
  end
end
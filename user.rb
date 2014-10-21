class User
  attr_accessor :id, :fname, :lname
  
  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL
    results.map { |result| User.new(result) }
  end
  
  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
      fname = ? AND lname = ?
    SQL
    results.map { |result| User.new(result) }
  end
  
  def authored_questions
    Question.find_by_author_id(self.id)
  end
  
  def authored_replies
    Reply.find_by_user_id(self.id)    
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end
  
  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT 
      CAST(COUNT(ql.questionid) AS FLOAT) / COUNT (DISTINCT(q.id)) 
    FROM
      users u
    JOIN 
      questions q
    ON
      u.id = q.authorid
    LEFT OUTER JOIN
      question_likes ql
    ON
      q.id = ql.questionid
    WHERE
      u.id =?  
    SQL
    results[0].values[0]
  end
end
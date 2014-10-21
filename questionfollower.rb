class QuestionFollower
  attr_accessor :relationshipid, :questionid, :userid
  
  def initialize(options = {})
    @relationshipid = options['relationshipid']
    @questionid = options['questionid']
    @userid = options['userid']
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        relationshipid = ?
    SQL
    results.map { |result| QuestionFollower.new(result) }
  end
  
  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_followers
      JOIN
        users u
      ON
        userid = u.id
      WHERE
        questionid = ?
    SQL
    results.map { |result| User.new(result) }
  end
  
  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_followers
      JOIN
        questions q
      ON
        questionid = q.id
      WHERE
        userid = ?
    SQL
    results.map { |result| Question.new(result) }
  end
end
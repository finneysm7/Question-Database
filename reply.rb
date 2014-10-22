
class Reply
  attr_accessor :reply_id, :body, :questionid, :userid, :parent_reply_id
  
  def initialize(options = {})
    @reply_id = options['reply_id']
    @body = options['body']
    @questionid = options['questionid']
    @userid = options['userid']
    @parent_reply_id = options['parent_reply_id']
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end
  
  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        userid = ?
    SQL
    results.map { |result| Reply.new(result) }
  end
  
  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        questionid = ?
    SQL
    results.map {|result| Reply.new(result)}
  end
  
  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, self.userid)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
  SQL
  results.map {|result| User.new(result)}
  end
  
  def question
    results = QuestionsDatabase.instance.execute(<<-SQL, self.questionid)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
  SQL
  results.map {|result| Question.new(result)}
  end
  
  def parent_reply
    results = QuestionsDatabase.instance.execute(<<-SQL, self.parent_reply_id)
    SELECT
      *
    FROM
      replies
    WHERE
      reply_id = ?
  SQL
  results.map {|result| Reply.new(result)}
  end
  
  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.reply_id)
    SELECT
      *
    FROM
      replies
    WHERE
      parent_reply_id = ?
  SQL
  results.map {|result| Reply.new(result)}
  end
  
  def save
    if self.reply_id.nil?
      QuestionsDatabase.instance.
      execute(<<-SQL, self.body, self.questionid, self.userid, self.parent_reply_id)
      INSERT INTO
        replies (body, questionid, userid, parent_reply_id)
      VALUES
        (?, ?, ?, ?)
      SQL
      @reply_id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.
      execute(<<-SQL, @body, @questionid, @userid, @parent_reply_id, self.reply_id)
      UPDATE
        replies
      SET 
        body = ?, questionid = ?, userid = ?, parent_reply_id = ?
      WHERE
        replies.reply_id = ?
      SQL
    end
  end
end

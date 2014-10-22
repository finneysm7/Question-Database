class Question
  attr_accessor :id, :title, :body, :authorid
  
  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @authorid = options['authorid']
  end
  
  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = ?
    SQL
    results.map { |result| Question.new(result) }
  end
  
  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT 
      *
    FROM
      questions
    WHERE
      authorid = ?
    SQL
    results.map { |result| Question.new(result) }
  end
  
  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, self.authorid)
      SELECT
        *
      FROM
        users
      WHERE
        id = ? 
    SQL
    results.map {|result| User.new(result) }
  end
  
  def replies
    Reply.find_by_question_id(self.id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def likers
    QuestionLike.likers_for_question_id(self.id)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
  def save
    if self.id.nil?
      QuestionsDatabase.instance.
      execute(<<-SQL, self.title, self.body, self.authorid)
      INSERT INTO
        questions (title, body, authorid)
      VALUES
        (?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.
      execute(<<-SQL, @title, @body, @authorid, self.id)
      UPDATE
        questions
      SET 
        title = ?, body = ?, authorid = ?
      WHERE
        questions.id = ?
      SQL
    end
  end
end
require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    
    self.results_as_hash = true
    self.type_translation = true
  end  
end

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
end

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
end

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
end

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
end

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
end

p User.find_by_id(1)
p Question.find_by_id(1)
p QuestionFollower.find_by_id(1)
p Reply.find_by_id(1)
p QuestionLike.find_by_id(1)
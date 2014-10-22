require 'singleton'
require 'sqlite3'
require_relative './user.rb'
require_relative './question.rb'
require_relative './questionfollower.rb'
require_relative './reply.rb'
require_relative './questionlike.rb'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    
    self.results_as_hash = true
    self.type_translation = true
  end  
end
 #
# p User.find_by_id(1)
# p Question.find_by_id(1)
# p QuestionFollower.find_by_id(1)
# p Reply.find_by_id(1)
# p QuestionLike.find_by_id(1)


seymore = User.find_by_name("Seymore", "Goldman")[0]
hugh = User.find_by_name("Hugh", "SilverHammer")[0]
q1 = Question.find_by_id(1)[0]
r1 = Reply.find_by_id(1)[0]
r3 = Reply.find_by_id(3)[0]
# p seymore.authored_replies
# p hugh.authored_replies

##
# p q1.replies
# p r1.author
# p r1.question
# p r1.parent_reply
# p r3.parent_reply
# p r1.child_replies
# qf1 = QuestionFollower.find_by_id(1)
# p QuestionFollower.followers_for_question_id(1)
# p QuestionFollower.followed_questions_for_user_id(2)
#p hugh.followed_questions
# QuestionFollower.most_followed_questions(1)
# p QuestionLike.num_likes_for_question_id(1)
# p QuestionLike.liked_questions_for_user_id(2)
# p q1.likers
# p q1.num_likes
# p seymore.liked_questions
# p QuestionLike.most_liked_questions(1)
mrman = Reply.new({'body' => 'U R DUM', 'questionid' => 3, 'userid' => 4})
p Reply.find_by_id(4)
mrman.save
p Reply.find_by_id(4)
mrs_miss = Reply.new({'reply_id' => 4, 'body' => 'Y U STOOPID', 'questionid' => 3,
  'userid' => 4})
p Reply.find_by_id(4)
mrs_miss.save
p Reply.find_by_id(4)

# p seymore.average_karma
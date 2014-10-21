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
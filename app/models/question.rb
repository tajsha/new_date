class Question < ActiveRecord::Base
    acts_as_messageable
    
  attr_accessible :answer, :question, :sender_id, :recipient_id, :conversation_id
  belongs_to :user

  belongs_to :sender,:class_name => 'User',:foreign_key => 'sender_id'

  belongs_to :recipient,:class_name => 'User',:foreign_key => 'recipient_id'

  belongs_to :message
  
  belongs_to :conversation
  
  def self.total_answer
      where('answer IS NOT NULL').count
    end
    
    def self.total_answer_cancelled
        where('answer IS NULL').count
      end
      
      def self.total_male
        count_of_males = Question.joins(:sender).where(users: {gender: 'male'}).uniq.count
      end
      
      def self.total_female
        count_of_males = Question.joins(:sender).where(users: {gender: 'female'}).uniq.count
      end

    
      def mailboxer_email(object)
          if self.no_email
            email
          else
              nil
          end
  end
  end
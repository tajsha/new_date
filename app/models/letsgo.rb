class Letsgo < ActiveRecord::Base
  acts_as_messageable
  attr_accessible :message, :content, :tag, :sender_id, :recipient_id, :conversation_id
  belongs_to :user
  belongs_to :message
  belongs_to :sender,:class_name => 'User',:foreign_key => 'sender_id'
  belongs_to :recipient,:class_name => 'User',:foreign_key => 'recipient_id'
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 360 }
  validates :user_id, presence: true
  scope :random, -> { order("RANDOM()") }
  
  def self.total_male
    count_of_males = Letsgo.joins(:user).where(users: {gender: 'male'}).uniq.count
  end
  
  def self.total_female
    count_of_males = Letsgo.joins(:user).where(users: {gender: 'female'}).uniq.count
  end
  
  def repost(user_object)
    new_letsgo = self.dup #duplicates the entire object, except for the ID
    new_letsgo.user_id = user_object.id
    new_letsgo.repost_from_user_id = self.id #save the user id of original repost, to keep track of where it originally came from
    new_letsgo.save
end

def is_repost?
  repost_from_user_id.present?
end

def original_user
  User.find(repost_from_user_id) if is_repost?
end
end
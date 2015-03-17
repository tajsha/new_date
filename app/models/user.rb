# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  zip_code               :string(255)
#  birthday               :string(255)
#  name                   :string(255)
#  username               :string(255)
#  gender                 :string(255)
#  ethnicity              :string(255)
#  sexuality              :string(255)
#  career                 :string(255)
#  education              :string(255)
#  religion               :string(255)
#  politics               :string(255)
#  children               :string(255)
#  height                 :string(255)
#  user_smoke             :string(255)
#  user_drink             :string(255)
#  about_me               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#


class User < ActiveRecord::Base
  acts_as_messageable
  has_secure_password
  attr_accessible :role, :user_id, :notification_id, :sender_id, :receiver_id, :conversation_id, :no_email, :average_response_time, :response_rate, :response_total, :name, :time_zone, :code, :lat, :lon, :city, :age, :age_end, :password_confirmation, :about_me, :feet, :inches, :password, :birthday, :career, :children, :education, :email, :ethnicity, :gender, :height, :name, :password_digest, :politics, :religion, :sexuality, :user_drink, :user_smoke, :username, :zip_code, :user_sex, :male_sexuality, :female_sexuality
  attr_accessor :user_sex
  # this prevented user from registering as I don't have timezone select on user reg form
  # validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)
  has_one :subscription
  has_one :search
  has_many :photos
  has_many :letsgos, dependent: :destroy
  belongs_to :default_photo, :class_name => "Photo"  
  belongs_to :location, :foreign_key => :zip_code, :primary_key => :zip_code
  has_many :notifications
  has_many :questions, foreign_key: :recipient_id
  has_many :sent_questions, class_name: 'Question', foreign_key: :sender_id
  belongs_to :zip
  belongs_to :avatar, class_name: 'Photo'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  validates_format_of :zip_code,
                  with: /\A\d{5}-\d{4}|\A\d{5}\z/,
                  message: "should be 12345 or 12345-1234"
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :username
  validates_presence_of :username
  validates_format_of :username, :with => /\A[a-zA-Z0-9]+\Z/, :message => "should only contain letters or numbers"
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40},
                       :on => :create
  before_create { generate_token(:auth_token) }
  ROLES = %w[admin user guest banned]
  scope :except_user, ->(user) { where('users.id != ?', user.id)}
  # models/user.rb
  after_create :setup_gallery
  before_save :set_age
  
  def similar
    arr = User.where(:gender => self.gender).where.not(:id => self.id)
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts arr.inspect
    puts self.location.state.inspect
    arr.select{|c| c.location.state == self.location.state }
  end
  
  def latitude
      location = Location.find_by_zip_code(zip_code)
      if location
        location.latitude
    end
  end
  
    def longitude
        location = Location.find_by_zip_code(zip_code)
        if location
          location.longitude
      end
    end
  
  def is_subscriber?
    subscriptions.size > 0 # or 'subscription'
  end
  
  def self.total_males
    where(gender: 'male').count
  end
  
  def self.total_females
    where(gender: 'female').count
  end
  
  def self.total_male_messages
    join_clause = "INNER JOIN users ON notifications.sender_id = users.id AND notifications.sender_type = 'User'"
    Notification.joins(join_clause).where(users: { gender: 'male' }).uniq.count 
  end
  
  def self.total_female_messages
    join_clause = "INNER JOIN users ON notifications.sender_id = users.id AND notifications.sender_type = 'User'"
    Notification.joins(join_clause).where(users: { gender: 'female' }).uniq.count 
  end
  
  def to_param
     username
   end
   
   def subscribed?
      subscription.present?
    end
    
    def paid?
      subscriptions.where(cancelled: nil).exists?
    end
    
    def reg?
      !subscription.cancelled? if subscription
    end
    
    def mailboxer_email(object)
        if self.no_email
          email
        else
            nil
        end
    end
  def location

      if Location.by_zip_code(self.zip_code.to_s).any?
          # you can return all here if you want more than one
          # for testing just returning the first one
          return Location.by_zip_code(self.zip_code.to_s).first
      else
          return nil
      end
  end
  
  def address
    "#{location.city}, #{location.state}" rescue nil
  end
  
  
   def over_18
      if birthday + 18.years > Date.today
        errors.add(:birthday, "can't be under 18")
      end
    end

    def age
      now = Time.now.utc.to_date
      now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    end
    
    def set_age
      self.age = Time.now.year - self.birthday.year
    end
      
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end
  
  def received_messages
      Message.received_by(self)
    end
 
 def unread_messages?
   unread_message_count > 0 ? true : false
 end
 
 def unread_messages
   received_messages.where('read_at IS NULL')
 end
 
 def sent_messages
   Message.sent_by(self)
 end
 
 def deleted_messages
   Message.where(recipient_deleted: self)
 end
 
 
 # Returns the number of unread messages for this user
 def unread_message_count
   eval 'messages.count(:conditions => ["recipient_id = ? AND read_at IS NULL", self.user_id])'
 end
 
  def to_s; username
  end
  
  def has_role?(role_name)
    role.present? && role.to_sym == role_name.to_sym
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def self.with_age_range(year_range)
    today = Date.today
    where birthday: (today - year_range.max.years)..(today - year_range.min.years)
  end
  
  def name
    return "#{first_name} #{last_name}"
   end
  
  private
  def setup_gallery
     Gallery.create(user: self)
   end
end

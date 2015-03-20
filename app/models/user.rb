class User < ActiveRecord::Base
    has_many :feedbacks
    attr_accessor :remember_token
    mount_uploader :picture, PictureUploader
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :answer1, presence: true, allow_blank: true
    validates :answer2, presence: true, allow_blank: true
    validate :picture_size
    
    #returns the hash digest of the given string
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    #returns a random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    #remembers a user in the database for use in persistent sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
        
        #cookies.permanent[:last_visited] = Time.now
         #   if params[:remember_me]
          #      user = @user_session.user
           # user.update_attributes(:remember_token => create_remember_token)
            #    cookies[:remember_token] = { :value => user.remember_token, :expires => 24.weeks.from_now }
            #end
    end
    
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def feed
        Feedback.where("user_id = ?", id)
    end
    
    private
    
    #validates the size of an uploaded picture
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB, please")
        end
    end
    
end

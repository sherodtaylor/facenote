class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible  :name, :uid, :provider, :email, :password,
                   :password_confirmation, :remember_me, :oauth,
                   :oauth_expires_at #, :fetch_completed

  has_many :friend_pages
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initailize.tap do |user|  
      user.name = auth.extra.raw_info.name
      user.provider = auth.uid
      user.email = auth.info.email
      user.oauth = auth.credentials.token
      user.auth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    @name = auth.extra.raw_info.name
    @email = auth.info.email
    unless user
       user = User.create(name:auth.extra.raw_info.name,
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          password:Devise.friendly_token[0,20],
                          oauth:auth.credentials.token,
                          oauth_expires_at: Time.at(auth.credentials.expires_at),
                         )
    # Usercreated.welcome_email.deliver
    end
   
    user
  end

  def self.new_with_session(params, session)
     super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
           user.email = data["email"] if user.email.blank?
        end
     end
  end
end

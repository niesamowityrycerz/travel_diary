class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         #:recoverable,
         :rememberable, 
         :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_omniauth(auth)
    # find the existing user; if one does not exist create
    # first_or_create automatically sets user.providr and user.uid with the appropriate values
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # create password for user who  in with google
      user.username = auth.info.name # assuming auth.info.name exists 
    end 
  end


end


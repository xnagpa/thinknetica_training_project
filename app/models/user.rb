class User < ActiveRecord::Base
  include Gravtastic
  gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]
  has_many :questions
  has_many :answers
  has_many :authorizations, dependent: :destroy

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    user = User.where(email: auth.info.email).first

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
    else

      password = Devise.friendly_token[0, 20]
      user = User.create!(email: auth.info.email.nil? ? "twitter#{Random.rand(1000)}@mail.ru" : auth.info.email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
    end
    user
  end
end

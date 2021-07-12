class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :omniauthable, omniauth_providers: [:facebook]
  
  has_one :shop, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  after_create do
    create_shop
  end
  
  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    user.remote_avatar_url = auth.info.image
    
    user.save!

    user
  end
end

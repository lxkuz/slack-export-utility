class User < ApplicationRecord
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
  end

  def self.find_by_omniauth(auth)
    User.where(provider: auth['provider'], uid: auth['uid']).first
  end

  def self.find_or_create_by_omniauth(auth)
    user = User.find_by_omniauth auth
    return user if user
    User.create_with_omniauth auth
  end
end

class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :user
  belongs_to :team

  validates :channel, :user, :team, presence: true
end

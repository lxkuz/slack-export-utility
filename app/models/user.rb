class User < ApplicationRecord
  belongs_to :team
  has_many :messages
  validates :name, :team, presence: true
end

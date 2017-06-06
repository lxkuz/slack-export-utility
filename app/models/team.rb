class Team < ApplicationRecord
  validates :token, :name, presence: true

  has_many :channels, dependent: :delete_all
  has_many :users, dependent: :delete_all
  has_many :messages, dependent: :delete_all

  serialize :token, EncryptedCoder.new

  def self.find_or_create_from_slack(auth)
    token = auth['credentials']['token']
    team_id = auth['info']['team_id']
    team = Team.find_by_slack_id(team_id)
    return team if team
    name = auth['info']['team']
    Team.create token: token, name: name, slack_id: team_id
  end

  def export!
    # TODO: use background job
    exporter = SlackExporter.new self
    exporter.export_team!
  end
end

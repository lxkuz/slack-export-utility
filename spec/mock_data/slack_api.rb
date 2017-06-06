class SlackApiMockData
  def self.users_list
    {
      'ok' => true,
      'members' => [
        {
          'id' => 'U023BECGF',
          'team_id' => 'T021F9ZE2',
          'name' => 'bobby',
          'deleted' => false,
          'color' => '9f69e7',
          'real_name' => 'Bobby Tables',
          'tz' => "America\/Los_Angeles",
          'tz_label' => 'Pacific Daylight Time',
          'tz_offset' => -25_200,
          'profile' => {
            'avatar_hash' => 'ge3b51ca72de',
            'current_status' => ' =>mountain_railway: riding a train',
            'first_name' => 'Bobby',
            'last_name' => 'Tables',
            'real_name' => 'Bobby Tables',
            'email' => 'bobby@slack.com',
            'skype' => 'my-skype-name'
          },
          'is_admin' => true,
          'is_owner' => true,
          'updated' => 1_490_054_400,
          'has_2fa' => false
        }
      ]
    }.to_json
  end

  def self.channels_list
    {
      'ok' => true,
      'channels' => [
        {
          'id' => channel_id,
          'name' => 'fun',
          'created' => 1_360_782_804,
          'creator' => 'U024BE7LH',
          'is_archived' => false,
          'is_member' => false,
          'num_members' => 6,
          'topic' => {
            'value' => 'Fun times',
            'creator' => 'U024BE7LV',
            'last_set' => 1_369_677_212
          },
          'purpose' => {
            'value' => 'This channel is for fun',
            'creator' => 'U024BE7LH',
            'last_set' => 1_360_782_804
          }
        }
      ]
    }.to_json
  end

  def self.channel_id
    'C024BE91L'
  end

  def self.channel_history
    {
      'ok' => true,
      'latest' => '1358547726.000003',
      'messages' => [
        {
          'type' => 'message',
          'ts' => '1358546515.000008',
          'user' => 'U2147483896',
          'text' => 'Hello'
        },
        {
          'type' => 'message',
          'ts' => '1358546515.000007',
          'user' => 'U2147483896',
          'text' => 'World',
          'is_starred' => true,
          'reactions' => [
            {
              'name' => 'space_invader',
              'count' => 3,
              'users' => %w(U1 U2 U3)
            },
            {
              'name' => 'sweet_potato',
              'count' => 5,
              'users' => %w(U1 U2 U3 U4 U5)
            }
          ]
        },
        {
          'type' => 'something_else',
          'ts' => '1358546515.000007',
          'wibblr' => true
        }
      ],
      'has_more' => false
    }.to_json
  end
end

require 'active_support/concern'

module TeamExporter
  extend ActiveSupport::Concern

  included do
    private

    def export_columns
      %w(User Channel
         Date DateTime
         UserCreatedDate
         ChannelCreatedDate)
    end

    def export_data(messages)
      messages.map do |m|
        [
          m.user.try(:name), m.channel.try(:name),
          _date(m.created_at), _datetime(m.created_at),
          _date(m.user.try(:created_at)),
          _date(m.channel.try(:created_at))
        ]
      end
    end

    def _datetime(val)
      val.try(:strftime, '%d/%m/%Y %H:%M')
    end

    def _date(val)
      val.try(:strftime, '%d/%m/%Y')
    end
  end
end

# frozen_string_literal: true

class TimeUtil

  # Normalize a timestamp to a more accurate time based on an offset of sent time
  # vs now time.
  #
  # Return a unix time (ms since epoch)
  #
  # see https://images.zenhubusercontent.com/5c75601cce38d251a29ce098/bf41aa5b-c908-4b08-a738-5e940d007170
  def self.device_adjust(normalize_at:, sent_at:)
    offset_secs = Time.now - Time.parse(sent_at)
    Time.parse(normalize_at) - offset_secs
  end
end

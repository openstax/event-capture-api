# frozen_string_literal: true

# Normalize a timestamp to a more accurate time based on an offset of sent time
# vs now time.
#
# see https://images.zenhubusercontent.com/5c75601cce38d251a29ce098/bf41aa5b-c908-4b08-a738-5e940d007170
class TimeUtil
  def self.apply_offset(normalize_at:, sent_at:)
    offset_secs = Time.now.utc - DateTime.parse(sent_at)
    offset_datetime = DateTime.parse(normalize_at) - offset_secs
    offset_datetime.strftime('%Q').to_i  #convert to unix time (ms since epoch)
  end
end

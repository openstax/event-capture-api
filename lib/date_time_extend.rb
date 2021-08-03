# frozen_string_literal: true

class DateTime
  # Extend for millisecond timestamp
  def floored_milliseconds_since_epoch
    (to_f * 1000).floor
  end
end

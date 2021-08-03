# frozen_string_literal: true

class Time
  # Extend Time for millisecond timestamps
  def floored_milliseconds_since_epoch
    (to_f * 1000).floor
  end
end

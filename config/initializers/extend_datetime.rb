# Need to extend DateTime for millisecond timestamps
class DateTime
  # Extend for millisecond timestamp
  def floored_milliseconds_since_epoch
    (to_f * 1000).floor
  end
end

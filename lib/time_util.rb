# frozen_string_literal: true

class TimeUtil
  # Normalize a timestamp to a more accurate time based on an offset of sent time
  # vs now time.
  #
  # Return a unix time (ms since epoch)
  #
  # see Designing Data-Intensive Applications by Martin Kleppman, Chapter 11: Stream Processing (p. 471)
  def self.infer_actual_occurred_at_from_client_timestamps(request_received_at:,
                                                           client_clock_occurred_at:,
                                                           client_clock_sent_at:)
    offset_secs = request_received_at - Time.parse(client_clock_sent_at)
    Time.parse(client_clock_occurred_at) + offset_secs
  end
end

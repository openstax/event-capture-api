Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = 'ActionController::API'

  # Log how many events of each type a request carried, not the events: their bodies hold
  # student activity and made each log line about 3 KB.
  config.lograge.custom_options = lambda do |event|
    params = event.payload[:params] || {}
    events = Array.wrap(params['events'])
    statements = params.key?('_json') ? Array.wrap(params['_json']) : Array.wrap(params['statement'])

    {
      event_types: events.filter_map { |e| e.dig('data', 'type') if e.is_a?(Hash) && e['data'].is_a?(Hash) }.tally.presence,
      statement_count: statements.size.nonzero?
    }.compact
  end
end

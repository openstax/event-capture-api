class RequestReceivedAt
  def initialize(app)
    @app = app
  end

  def call(env)
    env[:received_at] = Time.now
    @app.call(env)
  end
end

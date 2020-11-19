require 'openstax/auth/strategy_2'

class ApplicationController < ActionController::API
  include RescueFromUnlessLocal

  # will delete this as soon as we have anonymous users
  # we'll always have user ids
  TEMP_ANONYMOUS = '7c56ebf5-a850-44b1-a5e5-8e3866f6a248'

  def current_user_uuid
    @current_user_uuid ||= begin
      if Rails.application.load_testing? && request.headers['HTTP_LOADTEST_CLIENT_UUID']
        return request.headers['HTTP_LOADTEST_CLIENT_UUID']
      end

      if Rails.env.development? && ENV['STUBBED_USER_UUID']
        ENV['STUBBED_USER_UUID']
      else
        if ENV['STUBBED_USER_UUID']
          Rails.logger.warn("`STUBBED_USER_UUID` environment variable is set but not used in " \
                            "the #{Rails.env} environment.")
        end

        OpenStax::Auth::Strategy2.user_uuid(request) || TEMP_ANONYMOUS
      end
    end
  end


  def current_device_uuid
    @current_device_uuid ||= begin
      if Rails.env.development? && ENV['STUBBED_DEVICE_UUID']
        ENV['STUBBED_DEVICE_UUID']
      else
        request.cookies[Rails.application.secrets.accounts[:device_cookie_name]]
      end
    end
  end

  def render_unauthorized_if_no_current_user
    head :unauthorized if current_user_uuid.nil?
  end
end

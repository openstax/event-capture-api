require 'openstax/auth/strategy_2'

class ApplicationController < ActionController::API
  include RescueFromUnlessLocal

  # Sentinel value so we'll always have user and device ids
  ANONYMOUS_UUID = '00000000-0000-0000-0000-000000000000'

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

        OpenStax::Auth::Strategy2.user_uuid(request) || ANONYMOUS_UUID
      end
    end
  end


  def current_device_uuid
    @current_device_uuid ||= begin
      if Rails.env.development? && ENV['STUBBED_DEVICE_UUID']
        ENV['STUBBED_DEVICE_UUID']
      else
        request.cookies[Rails.application.secrets.accounts[:device_cookie_name]] || ANONYMOUS_UUID
      end
    end
  end

end

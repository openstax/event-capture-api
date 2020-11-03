class Api::V0::InfoController < Api::V0::BaseController
  # See Api::V0::InfoSwagger for documentation

  def info
    started_at = Time.now
    info_data = current_user_authorized_as_admin? ?
      EventCaptureInfo.new.extended :
      EventCaptureInfo.new.basic

    response = Api::V0::Bindings::InfoResults.new.build_from_hash(info_data.with_indifferent_access)

    response.overall_took_ms = ((Time.now - started_at)*1000).round

    render json: response, status: :ok
  end
end

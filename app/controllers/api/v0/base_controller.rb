class Api::V0::BaseController < ApplicationController
  include Swagger::Blocks
  include OpenStax::Swagger::Bind

  rescue_from_unless_local StandardError, send_to_sentry: true do |ex|
    render json: binding_error(status_code: 500, messages: [ex.message]), status: 500
  end

  rescue_from_unless_local AvroTurf::SchemaNotFoundError, Avro::IO::AvroTypeError do |ex|
    render json: binding_error(status_code: 422, messages: [ex.message]), status: 422
  end

  protected

  def current_user_authorized_as_admin?
    return true if Rails.env.development?
    return false if Rails.application.secrets.admin_uuids.blank?

    allowed_uuids = Rails.application.secrets.admin_uuids.split(',').map(&:strip)
    allowed_uuids.include?(current_user_uuid)
  end

  def binding_error(status_code:, messages:)
    Api::V0::Bindings::Error.new(status_code: status_code, messages: messages)
  end
end

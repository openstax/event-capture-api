class Api::V0::BaseController < ApplicationController
  include Swagger::Blocks
  include OpenStax::Swagger::Bind

  protected

  def binding_error(status_code:, messages:)
    Api::V0::Bindings::Error.new(status_code: status_code, messages: messages)
  end
end

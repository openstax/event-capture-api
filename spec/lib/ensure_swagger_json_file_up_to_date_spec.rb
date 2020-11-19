# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Ensure the static Swagger JSON file is up to date" do

  it "v0 is up to date" do
    latest_json = SWAGGER_JSON_PROC.call(0)
    static_json = JSON.parse(File.read("#{Rails.root}/app/bindings/api/v0/swagger.json"))

    expect(static_json.as_json).to eq latest_json.as_json
  end

end

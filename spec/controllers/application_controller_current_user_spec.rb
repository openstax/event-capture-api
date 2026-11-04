require 'rails_helper'

RSpec.describe ApplicationController do
  let(:uuid) { SecureRandom.uuid }
  let(:iss) { 'https://assignments.openstax.org' }
  let(:key) { OpenSSL::PKey::RSA.new(2048) }
  let(:request) { ActionDispatch::TestRequest.create }
  let(:controller) { described_class.new.tap { |c| c.request = request } }

  def launch_token(claims = {}, issuer: iss)
    jwt = JSON::JWT.new({ iss: issuer, sub: uuid, iat: Time.now.to_i, exp: Time.now.to_i + 300 }.merge(claims))
    jwt.header[:iss] = issuer
    jwt.kid = 'key-1'
    jwt.sign(key, :RS256).to_s
  end

  before do
    OpenStax::Auth::LaunchToken.reset_cache!
    jwks = { keys: [JSON::JWK.new(key.public_key, kid: 'key-1')] }.to_json
    allow(OpenStax::Auth::LaunchToken).to receive(:fetch_jwks)
      .and_return(OpenStax::Auth::LaunchToken.parse_jwks(jwks))
    allow(OpenStax::Auth::Strategy2).to receive(:user_uuid).and_return('sso-uuid')
  end

  after { OpenStax::Auth::LaunchToken.reset_cache! }

  it 'uses the launch token sub when an x-launch-token header is sent' do
    request.headers['X-Launch-Token'] = launch_token
    expect(controller.send(:current_user_uuid)).to eq uuid
    expect(OpenStax::Auth::LaunchToken).to have_received(:fetch_jwks)
      .with('https://assignments.openstax.org/.well-known/jwks.json')
  end

  it 'does not fall back to SSO when the launch token is invalid' do
    request.headers['X-Launch-Token'] = launch_token({ exp: Time.now.to_i - 3600 })
    expect(controller.send(:current_user_uuid)).to be_nil
  end

  it 'rejects launch tokens from outside openstax.org' do
    request.headers['X-Launch-Token'] = launch_token(issuer: 'https://evil.example.com')
    expect(controller.send(:current_user_uuid)).to be_nil
    expect(OpenStax::Auth::LaunchToken).not_to have_received(:fetch_jwks)
  end

  it 'falls back to the SSO token without an x-launch-token header' do
    expect(controller.send(:current_user_uuid)).to eq 'sso-uuid'
  end
end

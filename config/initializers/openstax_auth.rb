secrets = Rails.application.secrets.accounts[:sso]

OpenStax::Auth.configure do |config|
  config.strategy2.signature_public_key = secrets[:signature_public_key]
  config.strategy2.encryption_private_key = secrets[:encryption_private_key]
  config.strategy2.cookie_name = secrets[:cookie_name] || 'oxa'
  config.strategy2.encryption_algorithm = secrets[:encryption_algorithm] || 'dir'
  config.strategy2.encryption_method = secrets[:encryption_method] || 'A256GCM'
  config.strategy2.signature_algorithm = secrets[:signature_algorithm] || 'RS256'

  # Launch tokens (x-launch-token header) are trusted when signed by a key
  # published at <iss>/.well-known/jwks.json on this domain or a subdomain
  config.launch_token.trusted_domain = ENV.fetch('LAUNCH_TOKEN_TRUSTED_DOMAIN', 'openstax.org')
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || '127.0.0.1:6379', ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_TLS_URL'] || '127.0.0.1:6379', ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } } if ENV['REDIS_TLS_URL']
end

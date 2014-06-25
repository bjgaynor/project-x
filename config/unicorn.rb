worker_processes 4
timeout 120

# Enable streaming (for excel downloads)
port = (ENV["PORT"] || 3000).to_i
listen port, :tcp_nopush => false

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=20"
    ActiveRecord::Base.establish_connection
  end
end
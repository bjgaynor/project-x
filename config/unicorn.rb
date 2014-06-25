worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 120

# Enable streaming (for excel downloads)
port = (ENV["PORT"] || 3000).to_i
listen port, :tcp_nopush => false
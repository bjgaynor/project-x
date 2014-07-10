worker_processes 4
timeout 30

# Enable streaming (for excel downloads)
port = (ENV["PORT"] || 3000).to_i
listen port, :tcp_nopush => false
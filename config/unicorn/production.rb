worker_processes 2
preload_app true
timeout 30
listen 4000
stderr_path "log/unicorn.stderr.log"
stdout_path "log/unicorn.stderr.log"

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
worker_processes 2
preload_app true
timeout 30
listen 4000

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
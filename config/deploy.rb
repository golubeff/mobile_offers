set :application, 'mobile_offers'
set :repo_url, 'git@github.com:golubeff/mobile_offers.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/opt/apps/mobile_offers'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :bundle_flags, '--deployment --quiet --binstubs'
set :rails_env, "production"

set :default_env, { 'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }
set :keep_releases, 5
set :unicorn_config_path, "config/unicorn/production.rb"
set :unicorn_pid, "#{shared_path}/tmp/pids/unicorn.pid"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
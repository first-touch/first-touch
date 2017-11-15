# Change these
# config valid only for current version of Capistrano
lock '3.7.2'

set :stages, %w[production staging]
set :application, 'firsttouch'

set :repo_url, 'git@bitbucket.org:firsttouch/first-touch.git'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :user, 'deployer'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'
# Default value for linked_dirs is []
append :linked_dirs, %(client/node_modules)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'yarn install'
  task :yarn_install do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "cd '#{fetch(:frontend_path)}'; yarn install --ignore-engines;"
      end
    end
  end
  after :published, :yarn_install

  desc 'Build Frontend'
  task :build do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd '#{fetch(:frontend_path)}'; yarn run build"
    end
  end

  # before :starting,     :check_revision
  after  :finishing,    :yarn_install
  after  :yarn_install, :build
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

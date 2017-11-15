server "128.199.94.38", port: 22, roles: [:web, :app, :db], primary: true
set :application, "firsttouch"

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"

set :frontend_path, "#{release_path}/client"

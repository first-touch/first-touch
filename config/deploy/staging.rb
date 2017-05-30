server "128.199.94.38", port: 22, roles: [:web, :app, :db], primary: true
set :rails_env, 'production'

set :frontend_path, "#{release_path}/client"

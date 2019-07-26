# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '128.199.193.159', user: 'deployer', roles: %w[app db web], primary: true, port: 1026

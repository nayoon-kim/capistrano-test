# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }

## config/production.rb

## [변수 설정] Remote 서버 : 아이디
# AWS EC2 Ubuntu는 기본으로 아이디는 ubuntu 이다.
set :user, 'ubuntu'
## [Example] set :user, 'ubuntu'

## [변수 설정] REMOTE 서버 설정
set :remote_server_ip, "15.164.34.138"
# [Example] set :remote_server_ip, "52.78.236.246"

## [변수 설정] Remote서버에 대해 배포 환경변수 설정
set :rails_env, "production"
set :stage, :production

## Remote서버에서 프로젝트 배포가 이루어질 Path
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"

server fetch(:remote_server_ip), port: 22, roles: [:web, :app, :db], primary: true

set :sidekiq_role, :app
set :sidekiq_config, "[sidekiq.yml Full Path]"
set :sidekiq_env, 'production'

## SSH Remote 설정 (서버 아이디 및 pem Key 경로 설정)
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w([AWS EC2 Key Pair Full Path]) }
# set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(C:\Users\KCM\Desktop\ruby-kcm.pem) }
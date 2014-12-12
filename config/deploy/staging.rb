set :user, "www-ruby"
set :deploy_to, "/var/www/#{ fetch :application }"
set :branch, :development

server '148.251.127.106', user: fetch(:user), roles: %w{web app}

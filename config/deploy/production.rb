set :user, "rbdev"
set :deploy_to, "/home/#{ fetch :user }/#{ fetch :application }"
set :branch, :development # TODO switch to master

server '178.63.13.210', user: fetch(:user), roles: %w{web app}

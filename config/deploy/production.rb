set :user, "rbdev"
set :deploy_to, "/home/#{ fetch :user }/#{ fetch :application }"
set :branch, :development # TODO switch to master

server '144.76.4.166', user: fetch(:user), roles: %w{web app}

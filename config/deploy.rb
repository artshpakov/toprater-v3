lock '3.2.1'

set :application, 'toprater'
set :repo_url, 'git@github.com:Solver-Club/toprater.git'
set :scm, :git

set :pty, true
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5
set :deploy_via, :remote_cache
set :puma_config_file, "config/puma.rb"

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

set :puma_access_log, "#{ release_path }/log/puma.error.log"
set :puma_error_log,  "#{ release_path }/log/puma.access.log"

namespace :deploy do

  after :publishing, :restart
  after :restart, :cleanup

  desc "Restart puma"
  task :restart do
    on roles :web do
      execute "kill",  "-USR2 `cat #{ File.join shared_path, 'tmp', 'pids', 'puma.pid' }`"
    end
  end

end
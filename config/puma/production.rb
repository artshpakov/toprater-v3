environment 'production'
pidfile '/home/rbdev/toprater/shared/tmp/pids/puma.pid'
bind 'unix:///home/rbdev/toprater/shared/tmp/sockets/puma.sock'
stdout_redirect '/home/rbdev/toprater/shared/log/puma.access.log', '/home/rbdev/toprater/shared/log/puma.error.log', true
daemonize

threads 4, 32
workers 3
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
preload_app!

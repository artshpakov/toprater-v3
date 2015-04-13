environment 'production'
pidfile '/toprater/puma.pid'
stdout_redirect '/toprater/puma.access.log', '/toprater/puma.error.log', true

threads 4, 32
workers 3
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
preload_app!

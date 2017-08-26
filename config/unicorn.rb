# # set path to the application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/tmp"
working_directory app_dir

# Set unicorn options
worker_processes 2
preload_app true
timeout 180

# Path for the Unicorn socket
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Set path for logging
stderr_path "log/unicorn.stderr.log"
stdout_path "log/unicorn.stdout.log"

# Set proccess id path
pid "#{shared_dir}/pids/unicorn.pid"

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end

before_exec do |server| # 修正无缝重启unicorn后更新的Gem未生效的问题，原因是config/boot.rb会优先从ENV中获取BUNDLE_GEMFILE，而无缝重启时ENV['BUNDLE_GEMFILE']的值并未被清除，仍指向旧目录的Gemfile
  ENV["BUNDLE_GEMFILE"] = "#{app_path}/current/Gemfile"
end

app_dir = '%%{deploy_to}'
current_dir = '%%{current_path}'
shared_dir = '%%{shared_path}'

worker_processes 4
working_directory current_dir

listen "#{shared_dir}/tmp/unicorn.sock"
timeout 25
pid "#{shared_dir}/tmp/unicorn.pid"

stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

preload_app true

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

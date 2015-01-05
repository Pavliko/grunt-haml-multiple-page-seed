module.exports =
  copy_dist:
    command: [
      'tar -czf dist.tar.gz dist'
      'scp dist.tar.gz <%= deploy.user %>@<%= deploy.host %>:<%= deploy.deploy_to %>releases/'
      'rm dist.tar.gz'
    ].join(' && ')
  unpack_dist:
    command: [
      'ssh <%= deploy.user %>@<%= deploy.host %> "cd <%= deploy.deploy_to %>releases/'
      'tar xzf dist.tar.gz'
      'rm dist.tar.gz'
      'echo $(date +%s) > ../deploy.current'
      'mv dist \\\$(cat ../deploy.current)'
      'cd <%= deploy.deploy_to %>'
      'rm <%= deploy.static_path %>'
      'mkdir -p <%= deploy.static_path %>'
      'rm -rf <%= deploy.static_path %>'
      'ln -sf releases/\\\$(cat deploy.current) <%= deploy.static_path %>"'
    ].join(' && ')
  copy_backend:
    command: [
      'tar -czf backend.tar.gz backend'
      'scp backend.tar.gz <%= deploy.user %>@<%= deploy.host %>:<%= deploy.deploy_to %>releases/'
      'rm backend.tar.gz'
    ].join(' && ')
  unpack_backend:
    command: [
      'ssh <%= deploy.user %>@<%= deploy.host %> "cd <%= deploy.deploy_to %>releases/'
      'tar xzf backend.tar.gz'
      'rm backend.tar.gz'
      'cp -rf backend/* \\\$(cat ../deploy.current)'
      'cd <%= deploy.deploy_to %>'
    ].join(' && ')
  sync_nginx_conf:
    command: [
      'scp app/config/nginx.conf <%= deploy.user %>@<%= deploy.host %>:<%= deploy.deploy_to %>shared/config/nginx.conf.new'
      'ssh <%= deploy.user %>@<%= deploy.host %> "cd <%= deploy.deploy_to %>shared/config/'
      'mv -f nginx.conf nginx.conf.back'
      'mv -f nginx.conf.new nginx.conf"'
    ].join(' && ')
  deploy_create:
    command: [
      'ssh <%= deploy.user %>@<%= deploy.host %> "mkdir -p <%= deploy.deploy_to %>'
      'chmod g+rx,u+rwx <%= deploy.deploy_to %>'
      'cd <%= deploy.deploy_to %>'
      'mkdir -p releases'
      'chmod g+rx,u+rwx releases'
      'mkdir -p shared'
      'chmod g+rx,u+rwx shared'
      'mkdir -p shared/tmp'
      'chmod g+rx,u+rwx shared/tmp'
      'mkdir -p shared/config'
      'chmod g+rx,u+rwx shared/config'
      'touch shared/config/nginx.conf"'
    ].join(' && ')
  use:
    cmd: (project) ->
      console.log arguments
      "rm -f app && ln -s ../static-sites/#{project} app"

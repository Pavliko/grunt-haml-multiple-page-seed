module.exports =
  pack_dist:
    command: 'tar -czf dist.tar.gz dist'
  copy_dist:
    command: 'scp dist.tar.gz <%= deploy.user %>@<%= deploy.host %>:<%= deploy.deploy_to %>releases/ && rm dist.tar.gz'
  unpack_dist:
    command: [
      'ssh <%= deploy.user %>@<%= deploy.host %> "cd <%= deploy.deploy_to %>releases/'
      'tar xzf dist.tar.gz'
      'rm dist.tar.gz'
      'echo $(date +%s) > ../deploy.current'
      'mv dist \\\$(cat ../deploy.current)'
      'cd <%= deploy.deploy_to %>'
      'rm current'
      'ln -sf releases/\\\$(cat deploy.current) current"'
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

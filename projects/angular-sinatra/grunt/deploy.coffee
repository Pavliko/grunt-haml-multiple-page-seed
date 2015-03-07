module.exports =
  user: 'user'
  host: 'deploy_to_server(host or ip)'
  hostname: 'yourdomain.com'
  name: 'sinatra'
  deploy_to_folder: '/home/user/'
  deploy_to: '<%= deploy.deploy_to_folder %><%= deploy.name %>'
  backend: true

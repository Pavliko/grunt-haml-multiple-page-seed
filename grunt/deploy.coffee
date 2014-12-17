module.exports =
  username: 'user'
  host: 'example.com'
  name: 'sample'
  deploy_to_folder: '/var/www/'
  deploy_to: '<%= deploy.deploy_to_folder %>/<%= deploy.name %>/'

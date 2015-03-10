# Static pages

Grunt based multiple sites development an deployment engine.
Fast and easy create and deploy small static sites based or sites with Sinatra backend.

##To run example project do
```
npm install -g rmpm
rnmp install
ln -s projects/angular-sinatra app
bower install
grunt serve
```

##To deploy example project do
- Setup projects/angular-sinatra/grunt/deploy.coffee
- gem install bundler #on your server
```
grunt deploy:setup
```
- include nginx config "/path/to/deploy/app_name/shared/config/nginx.config"
- restart nginx

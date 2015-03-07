_ = require('lodash')

module.exports = (grunt) ->
  deploy:
    stdout: true
    stderr: true
    command: (command='all')->
      clt =
        commands: []
        init: ->
          _.extend this, grunt.config.get('deploy')
          @current_path = "#{@deploy_to}/current"
          @shared_path = "#{@deploy_to}/shared"

        deploy: ->
          @initDeploy()
          @copyStatic()
          @copyBackend()
          @linkCurrent()
          @restart()

        initDeploy: ->
          @clean_version()
          @push [
            "echo 'Start deploy release #{@version} to #{@user}@#{@host}:#{@deploy_to}'"
            @sshCommands 'Create static folder', [
              "cd #{@deploy_to}/releases/"
              "mkdir -p #{@version}"
            ]
          ]

        push: (cmd) ->
          if _.isArray(cmd)
            @commands = @commands.concat(cmd)
          else
            @commands.push(cmd)

        clean_version: ->
          @version = (new Date()).toJSON().replace(/:/g, '_').replace(/\..*/, '')

        sshCommands: (message, array) ->
          array.unshift "source ~/.bash_profile && source ~/.bashrc"
          "echo 'SSH: #{message}' && ssh #{@user}@#{@host} \"#{array.join(' && ')}\""

        copyStatic: ->
          @push [
            "echo 'Pack static...'"
            'tar -czf tmp/dist.tar.gz dist'
            "echo 'Copy static'"
            "scp tmp/dist.tar.gz #{@user}@#{@host}:#{@deploy_to}/releases/#{@version}/dist.tar.gz"
            'rm -f tmp/dist.tar.gz'
            @sshCommands 'Unpack static', [
              "cd #{@deploy_to}/releases/#{@version}"
              'tar xzf dist.tar.gz'
              'mv -f dist public'
              'rm -f dist.tar.gz'
            ]
          ]

        copyBackend: ->
          return unless @backend
          @push [
            "echo 'Pack backend...'"
            'tar -czf tmp/backend.tar.gz app/backend/*'
            "scp tmp/backend.tar.gz #{@user}@#{@host}:#{@deploy_to}/releases/#{@version}/backend.tar.gz"
            'rm -f tmp/backend.tar.gz'
            @sshCommands 'Unpack backend', [
              "cd #{@deploy_to}/releases/#{@version}"
              'tar xzf backend.tar.gz'
              'mv app/backend/* ./'
              'rm -rf app/backend/'
              'rm -f backend.tar.gz'
              "BUNDLE_PATH=#{@shared_path}/vendor/bundle bundle install"
            ]
          ]

        linkCurrent: ->
          @push(
            @sshCommands "Link release #{@version} to current", [
              "rm -f #{@current_path}"
              "ln -sf #{@deploy_to}/releases/#{@version} #{@current_path}"
            ]
          )

        restart: ->
          @unicornClt('restart') if @backend

        setup: ->
          @push [
            @sshCommands 'Create structure...',[
              "mkdir -p #{@deploy_to}"
              "chmod g+rx,u+rwx #{@deploy_to}"
              "touch #{@current_path}"
              "mkdir -p #{@deploy_to}/releases"
              "chmod g+rx,u+rwx #{@deploy_to}/releases"
              "mkdir -p #{@shared_path}"
              "chmod g+rx,u+rwx #{@shared_path}"
              "mkdir -p #{@shared_path}/tmp"
              "chmod g+rx,u+rwx #{@shared_path}/tmp"
              "mkdir -p #{@shared_path}/log"
              "chmod g+rx,u+rwx #{@shared_path}/log"
              "mkdir -p #{@shared_path}/config"
              "chmod g+rx,u+rwx #{@shared_path}/config"
              "mkdir -p #{@shared_path}/scripts"
              "chmod g+rx,u+rwx #{@shared_path}/scripts"
              "mkdir -p #{@shared_path}/vendor/bundle"
              "chmod g+rx,u+rwx #{@shared_path}/vendor/bundle"
            ]
          ]

          @updateNginxConf()
          @updateUnicornConf()
          @updateUnicornClt()
          @updateMonitConf()

          @push @sshCommands('Chmod scripts', [ "chmod g+rx,u+rwx #{@shared_path}/scripts/*" ])
          @push @sshCommands('Install bundler', [ 'gem install bundler' ]) if @backend

          grunt.task.run('deploy')

        updateFile: (source, target, condition = true) ->
          if condition &&  grunt.file.exists source
            file = target.split('/')
            file = file[file.length - 1]
            grunt.file.write("tmp/#{file}", @replaceString(grunt.file.read(source)))
            @push [
              "echo 'Update #{file}'"
              "scp tmp/#{file} #{@user}@#{@host}:#{@shared_path}/#{target}"
              "rm -f tmp/#{file}"
            ]

        updateNginxConf:   -> @updateFile 'app/config/nginx.conf',         'config/nginx.conf'
        updateUnicornConf: -> @updateFile 'app/backend/config/unicorn.rb', 'config/unicorn.rb', @backend
        updateUnicornClt:  -> @updateFile 'app/backend/scripts/unicorn',   'scripts/unicorn',   @backend
        updateMonitConf:   -> @updateFile 'app/config/monit.conf',         'config/monit.conf'

        unicornClt: (command) ->
          @push @sshCommands "Unicorn #{command}", [ "#{@shared_path}/scripts/unicorn #{command}" ]

        replaceString: (string) ->
          matches = string.match(/%%\{([^\}]+)\}/g) || []
          self = this

          for match in matches
            if match
              replace = match.substring(3, match.length - 1).trim()
              replacement = eval("self.#{replace}")
              string = string.replace(match, replacement)

          string

        run: ->
          return @commands.join ' && '

      clt.init()

      switch command
        when 'all'
          clt.deploy()
        when 'setup'
          clt.setup()
        when 'unicorn'
          clt.unicornClt(arguments[1])
        when 'sync'
          clt["update#{arguments[1]}"]()
      
      clt.run()

  use:
    cmd: (project) ->
      console.log arguments
      "rm -f app && ln -s ../static-sites/#{project} app"

#
# Cookbook Name:: python_cookbook
# Recipe:: virtualenv
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

Chef::Log.info('app_deploy recipe')


node[:deploy].each do |application, deploy|
    
    # amazon aws built-in cookbook
    opsworks_deploy do
        app application
        deploy_data deploy
    end

    full_venv_path = File.join(deploy[:deploy_to], deploy[:venv_path])

    # custom cookbook to install virtualenv 
    virtualenv_install do
        app application
        user deploy[:user]
        group deploy[:group]

        deploy_to deploy[:deploy_to]
        venv_path deploy[:venv_path]
        full_venv_path full_venv_path
        directory_mode deploy[:directory_mode]

        pip_packages deploy[:pip_packages]
    end
    
    # install requirements
    requirements_path = ::File.join(deploy[:deploy_to], 'current', Helpers.django_setting(deploy, 'requirements', node))
    pip_cmd = ::File.join(full_venv_path, 'bin', 'pip')
    
    Chef::Log.info("Installing using requirements file: #{requirements_path}")

    execute "#{pip_cmd} install -r #{requirements_path}" do
        only_if { ::File.exists?(requirements_path) }

        cwd ::File.join(deploy[:deploy_to], 'current')
        user deploy[:user]
        group deploy[:group]

        # seems that if we don't set the HOME env var pip tries to log to /root/.pip, which fails due to permissions
        # setting HOME also enables us to control pip behavior on per-project basis by dropping off a pip.conf file there
        # GIT_SSH allow us to reuse the deployment key used to clone the main
        # repository to clone any private requirements
        environment 'HOME' => ::File.join(deploy[:deploy_to], 'shared')
    end
    
    
    django_cfg = ::File.join(deploy[:deploy_to], 'current', Helpers.django_setting(deploy, 'settings_file', node))
    Chef::Log.info('django_cfg: ' + django_cfg)

    # Create local config settings
    template django_cfg do
        source Helpers.django_setting(deploy, 'settings_template', node) || "settings_local.py.erb"
        owner deploy[:user]
        group deploy[:group]
        mode 0644

        variables Hash.new
        variables.update deploy

        variables.update :django_database => Helpers.django_setting(deploy, 'database', node)

        action :create
    end
end





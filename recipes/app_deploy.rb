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

    # custom cookbook to install virtualenv 
    virtualenv_install do
        app application
        user deploy[:user]
        group deploy[:group]

        deploy_to deploy[:deploy_to]
        venv_path deploy[:venv_path]
        full_venv_path File.join(deploy[:deploy_to], deploy[:venv_path])
        directory_mode deploy[:directory_mode]

        pip_packages deploy[:pip_packages]
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

        # return deploy["django_#{name}"] || node['deploy_django'][name]
        Chef::Log.info('============ django_database ============')
        Chef::Log.info(:django_database => Helpers.django_setting(deploy, 'database', node))
        Chef::Log.info('=========================================')
        
        variables.update :django_database => Helpers.django_setting(deploy, 'database', node)

        action :create
    end
end





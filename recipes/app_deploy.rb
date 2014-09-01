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
end

#
# Cookbook Name:: python_cookbook
# Recipe:: virtualenv
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

Chef::Log.info('virtualenv recipe')

# run virtualenv setup
node[:deploy].each do |application, deploy|
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

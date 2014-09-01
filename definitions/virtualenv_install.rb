#
# Cookbook Name:: python_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


define :virtualenv_install do
    Chef::Log.info('virtualenv definition')
    # "deploy::default" has created user/group and directory for upload_to
    # at this moment, so we need to create path to the virtualenv and install it
    
    app = params[:application]
    user = params[:user]
    group = params[:group]

    deploy_to = params[:deploy_to]
    venv_path = params[:venv_path]
    full_venv_path = params[:full_venv_path]

    directory_mode = params[:directory_mode]
    pip_packages = params[:pip_packages]

    # Create directory for the parent of virtualenv
    directory File.join(full_venv_path, '..') do
        owner user
        group group
        mode directory_mode
        recursive true
        action :create
    end


    # Create a virtual environment
    python_virtualenv full_venv_path do
        interpreter "python2.7"
        owner user
        group group
        action :create
    end

    # Install packages to a virtualenv
    # warning, the hack is used:
    #   we skip version and use package name with concatenated version
    # (each package is similar to requirements.txt line)
    pip_packages.each do |package|
        python_pip package do
            virtualenv full_venv_path
            user user
            group group
            action :install
        end
    end
end

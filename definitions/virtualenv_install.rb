#
# Cookbook Name:: python_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# include_recipe "python"

define :virtualenv_setup do
    user = node[:user]
    group = node[:group]
    application_name = node[:application_name]
    base_path = node[:setup][:base_path]
    venv_path = node[:setup][:venv_path]
    directory_mode = node[:directory_mode]
    full_venv_path = File.join(base_path, application_name, venv_path)
    base_path = node[:setup][:base_path]
    pip_packages = node[:setup][:pip_packages]

    group group do
        action :create
        not_if 'getent group ' + group
    end

    user user  do
        supports :manage_home => true
        gid group
        home "/home/" + user
        comment "App User"
        shell "/bin/bash"
        password ""
        not_if 'getent passwd ' + user
        action:create
    end

    # Create directory tree
    directory File.join(full_venv_path, '..') do
        owner user
        group group
        mode directory_mode
        recursive true
        action :create
    end

    directory File.join(base_path, application_name) do
        owner user
        group group
        mode directory_mode
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
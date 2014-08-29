#
# Cookbook Name:: python_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

user = node[:user]
group = node[:group]
application_name = node[:application_name]
base_path = node[:deploy][:base_path]
venv_path = node[:deploy][:venv_path]
directory_mode = node[:directory_mode]
full_venv_path = File.join(base_path, application_name, venv_path)


# Create directory tree
directory File.join(base_path, application_name) do
  owner user
  group group
  mode directory_mode
  action :create
  recursive true
end

# Create a virtual environment
python_virtualenv full_venv_path do
   interpreter "python2.7"
   owner user
   group group
   action :create
end

# Install Django to a virtualenv
python_pip "django" do
   virtualenvfull_venv_path
   user user
   group group
   action :install
end

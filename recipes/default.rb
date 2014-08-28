#
# Cookbook Name:: python_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



include_recipe "python"

# Create directory tree
directory '/var/www/app/var/' do
  owner 'ubuntu'
  group 'ubuntu'
  mode 0755
  action :create
  recursive true
end

# Create a virtual environment
python_virtualenv '/var/www/app/var/.env' do
   interpreter "python2.7"
   owner 'ubuntu'
   group 'ubuntu'
   action :create
end

# Install Django to a virtualenv
python_pip "django" do
   virtualenv '/var/www/app/var/.env'
   user 'ubuntu'
   group 'ubuntu'
   action :install
end

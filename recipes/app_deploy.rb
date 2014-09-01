#
# Cookbook Name:: python_cookbook
# Recipe:: virtualenv
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

Chef::Log.info('app_deploy recipe')

# run virtualenv setup

#virtualenv_install do
#end

node[:deploy].each do |application, deploy|
  opsworks_deploy do
      app application
      deploy_data deploy
  end
end

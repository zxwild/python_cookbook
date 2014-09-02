source 'https://api.berkshelf.com'

cookbook 'python', '1.4.6'

def opsworks_cookbook(name)
  cookbook name, { :github => "aws/opsworks-cookbooks", :rel => name, :tag => 'release-chef-11.10' }
end

opsworks_cookbook 'dependencies'
opsworks_cookbook 'gem_support'
opsworks_cookbook 'scm_helper'
opsworks_cookbook 'ssh_users'
opsworks_cookbook 'haproxy'
opsworks_cookbook 'mod_php5_apache2'
opsworks_cookbook 'opsworks_agent_monit'
opsworks_cookbook 'opsworks_commons'
opsworks_cookbook 'opsworks_initial_setup'
opsworks_cookbook 'opsworks_java'
opsworks_cookbook 'opsworks_nodejs'
opsworks_cookbook 'deploy'
opsworks_cookbook 'ssh_host_keys'
opsworks_cookbook 'memcached'
opsworks_cookbook 'mysql'
opsworks_cookbook 'nginx'
opsworks_cookbook 'apache2'

# opsworks_cookbook 'opsworks_bundler'
# opsworks_cookbook 'opsworks_cleanup'
# opsworks_cookbook 'opsworks_custom_cookbooks'
# opsworks_cookbook 'opsworks_ganglia'
# opsworks_cookbook 'opsworks_rubygems'
# opsworks_cookbook 'opsworks_shutdown'

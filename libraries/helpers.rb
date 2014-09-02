module Helpers
  def self.django_setting(deploy, name, node)
    # Return the app value or the global default
    return deploy["django_#{name}"] || node['deploy_django'][name]
  end
end

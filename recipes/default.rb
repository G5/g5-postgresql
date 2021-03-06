template '/etc/default/locale' do
  source 'locale'
  mode '0644'
end

include_recipe 'postgresql::apt_pgdg_postgresql'
include_recipe 'postgresql::contrib'

execute 'Create a vagrant db user' do
  command 'sudo -u postgres sh -c "dropuser vagrant; createuser -ds vagrant"'
end

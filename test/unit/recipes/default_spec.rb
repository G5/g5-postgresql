require 'spec_helper'

describe 'g5-postgresql::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['postgresql']['password']['postgres'] = postgres_password
    end.converge(described_recipe)
  end

  let(:postgres_password) { 'my_secret' }

  it 'sets up the locale template' do
    expect(chef_run).to create_template('/etc/default/locale').with(
      source: 'locale',
      mode: '0644'
    )
  end

  it 'includes the recipe for the pgdg apt repository' do
    expect(chef_run).to include_recipe('postgresql::apt_pgdg_postgresql')
  end

  it 'includes the recipe to install postgresql server' do
    expect(chef_run).to include_recipe('postgresql::server')
  end

  it 'creates a vagrant db user' do
    expect(chef_run).to run_execute('sudo -u postgres psql -c "CREATE USER vagrant CREATEDB SUPERUSER"')
  end
end
node[:deploy].each do |app_name, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code "curl -sS https://getcomposer.org/installer | php && php composer.phar install --no-dev"
  end
end

apt_repository 'php5-5.6' do
  uri node['php5_ppa']['uri']
  key node['php5_ppa']['key']
  keyserver node['php5_ppa']['key_server']
  components ['trusty', 'main']
end

# Install Git using new source repo
package 'php5-fpm' do
  action :install
end

#Install PHP modules
node['php5_ppa']['modules'].each do |install_packages|
  package install_packages do
    action :install
  end
end

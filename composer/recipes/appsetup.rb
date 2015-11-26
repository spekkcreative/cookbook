node[:deploy].each do |app_name, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code "curl -sS https://getcomposer.org/installer | php && php composer.phar install --no-dev"
  end
end
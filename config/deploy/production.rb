config = YAML.load(File.read(File.expand_path('../../deployer.yml', __FILE__)))

require 'bundler/capistrano'
require 'puma/capistrano'

server config['CAP_SERVER'], :web, :app, :db, primary: true

set :user, config['CAP_USER']
set :application, config['CAP_APP_NAME']
set :deploy_to, "/home/#{user}/web-app"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, config['CAP_GIT_REPO']
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    run "cp /home/#{application}/default-config/database.yml #{shared_path}/config/database.yml"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/omniauth.yml #{release_path}/config/omniauth.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
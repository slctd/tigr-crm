config = YAML.load(File.read(File.expand_path('../deployer-demo.yml', __FILE__)))

require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server config['CAP_SERVER'], :web, :app, :db, primary: true

set :whenever_command, 'bundle exec whenever'
require 'whenever/capistrano'

set :user, config['CAP_USER']
set :application, config['CAP_APP_NAME']
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, config['CAP_GIT_REPO']
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

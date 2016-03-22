set :stages, %w(production demo)
set :default_stage, 'demo'
require 'capistrano/ext/multistage'
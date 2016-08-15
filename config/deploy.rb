set :application, 'cocca-api'
set :repo_url, 'https://github.com/catameojc/cocca-api.git'
set :branch, ENV['REVISION'] || ENV['BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :rails_env, 'production'

set :deploy_to, '/srv/cocca-api'
set :log_level, :info
set :linked_files, %w{config/secrets.yml config/database.yml config/exception_notification.yml config/registry.yml config/sidekiq.yml config/epp.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, { path: "$PATH:/usr/pgsql-9.3/bin" }

set :rbenv_type, :user
set :rbenv_ruby, proc { `cat .ruby-version`.chomp }.call
set :rbenv_map_bins, %w{rake gem bundle ruby rails unicorn}

set :bundle_jobs, 4
set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }

set :sidekiq_concurrency, 1
set :sidekiq_processes, 2
set :sidekiq_options_per_process, ['--queue queue_cocca_records', '--queue sync_cocca_records']

set :whenever_roles, ->{ :app }

after 'deploy:publishing',  'deploy:restart'
after 'deploy:updated',     'whenever:update_crontab'
after 'deploy:reverted',    'whenever:update_crontab'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

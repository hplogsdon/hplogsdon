
# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
set :application,       'hplogsdon.jekyll'
set :repository,        '_site'
set :scm,               :none
set :deploy_via,        :copy
set :copy_compression,  :gzip
set :use_sudo,          false
set :host,              'hplogsdon'
set :port,              22

# =============================================================================
# ROLES
# =============================================================================
role :web, host
role :app, host
role :db,  host, :primary => true

set :user,      'howard'
set :group,     'wheel'

set :deploy_to, "/usr/local/www/#{application}"

ssh_options[:paranoid]    = false
default_run_options[:pty] = true

# =============================================================================
# TASKS
# =============================================================================
before "deploy:update", "deploy:jekyll"
namespace :deploy do

  [ :start, :stop, :restart, :finalize_update ].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do
    end
  end

  desc "Run jekyll to regenerate site"
  task :jekyll do
    %x( rm -rf _site/* && jekyll )
  end

end

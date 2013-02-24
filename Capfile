load 'deploy'

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
set :application,       'hplogsdon.blog'
set :repository,        '_site'
set :domain,            'hplogsdon.com'
set :scm,               :none
set :deploy_via,        :copy
set :copy_compression,  :gzip
set :use_sudo,          false
set :host,              'hplogsdon'
set :port,              22

set :deploy_to, "/usr/local/www/#{application}"

ssh_options[:paranoid]    = false
default_run_options[:pty] = true


# =============================================================================
# ROLES
# =============================================================================
role :web, host
role :app, host
role :db,  host, :primary => true


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
    system "jekyll _site --no-auto"
  end

end

module UseScpForDeployment
  def self.included(base)
    base.send(:alias_method, :old_upload, :upload)
    base.send(:alias_method, :upload,     :new_upload)
  end

  def new_upload(from, to, options={}, &block)
    old_upload(from, to, options.merge(:via => :scp), &block)
  end
end

Capistrano::Configuration.send(:include, UseScpForDeployment)

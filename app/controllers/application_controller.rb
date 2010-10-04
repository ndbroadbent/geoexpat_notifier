class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :retrieve_last_run_time

  def retrieve_last_run_time
    last_run_file = File.join(Rails.root, 'config', 'last_run.yml')
    @last_run = YAML.load_file(last_run_file) || {}
  end

end


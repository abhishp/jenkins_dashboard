require 'rspec'
require 'webmock/rspec'
require 'uri'
require_relative '../hash_extensions'

def require_job path
  require File.expand_path '../../jobs/' + path, __FILE__
end

class SCHEDULER
  def self.every(_,_)
  end
end

module Builds
  JENKINS_CONFIG = {
      baseURL: 'http://jenkins-url',
      username: 'username',
      password: 'password',
      project: 'project'
  }
  BUILDS_CONFIG = {

  }
end

RSpec.configure do |config|
  config.color = true
  config.order = 'random'
end

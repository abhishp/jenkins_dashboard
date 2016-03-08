require 'rspec'
require 'webmock/rspec'
require 'uri'

def require_job path
  require File.expand_path '../../jobs/' + path, __FILE__
end

class SCHEDULER
  def self.every(ignoreme)
  end
end

module Builds
  BUILD_CONFIG = {
    "jenkinsBaseUrl" => 'http://jenkins-url'
  }
  JENKINS_CONFIG = {
      baseURL: 'http://jenkins-url',
      username: 'username',
      password: 'password',
      project: 'project'
  }
end

RSpec.configure do |config|
  config.color = true
  config.order = 'random'
end

module Builds
  JENKINS_CONFIG_FILE = 'config/jenkins.yml'
  BUILDS_CONFIG_FILE = 'config/builds.yml'
  JENKINS_CONFIG = HashExtensions.indifferent_access(YAML.load_file(JENKINS_CONFIG_FILE)['jenkins']) if File.exists?(JENKINS_CONFIG_FILE)
  BUILDS_CONFIG = HashExtensions.indifferent_access(YAML.load_file(BUILDS_CONFIG_FILE)['builds']) if File.exists?(BUILDS_CONFIG_FILE)
end

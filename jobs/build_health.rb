SUCCESS = 'Successful'
FAILED = 'Failed'
ABORTED = 'Aborted'

BUILD_STATUS = {
    'SUCCESS' => SUCCESS,
    'FAILURE' => FAILED,
    'ABORTED' => ABORTED,
    nil => 'Running'
}

def api_functions
  return {
    'Jenkins' => lambda { |build_id| get_jenkins_build_health build_id}
  }
end

def get_url(url, auth = nil)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  if uri.scheme == 'https'
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  request = Net::HTTP::Get.new(uri.request_uri)

  if auth != nil
    request.basic_auth *auth
  end

  response = http.request(request)
  HashExtensions.indifferent_access(JSON.parse(response.body))
end

def calculate_health(successful_count, count)
  (successful_count / count.to_f * 100).round(2)
end

def get_build_health(build)
  api_functions[build[:server]].call(build[:id])
end

def get_latest_run_build(builds)
  builds.first[:result] != 'ABORTED' ? builds.first : get_latest_run_build(builds[1, -1])
end

def get_jenkins_build_health(build_id)
  url = "#{Builds::JENKINS_CONFIG[:baseURL]}/view/#{Builds::JENKINS_CONFIG[:project]}/job/#{build_id}/api/json?tree=builds[status,timestamp,id,result,duration,url,fullDisplayName]"
  build_info = get_url URI.encode(url), [Builds::JENKINS_CONFIG[:username], Builds::JENKINS_CONFIG[:password]]
  builds = build_info[:builds]
  builds_with_status = builds.select { |build| !build[:result].nil? }
  successful_count = builds_with_status.count { |build| build[:result] == 'SUCCESS' }
  latest_build = get_latest_run_build(builds)
  {
    name: latest_build[:fullDisplayName],
    status: BUILD_STATUS[latest_build[:result]],
    duration: latest_build[:duration] / 1000,
    link: latest_build[:url],
    health: calculate_health(successful_count, builds_with_status.count),
    time: latest_build[:timestamp]
  }
end

SCHEDULER.every '10s', first_in: 0 do
  Builds::BUILDS_CONFIG.each_pair do |build_name, build_config|
    send_event(build_name, get_build_health(build_config))
  end
end

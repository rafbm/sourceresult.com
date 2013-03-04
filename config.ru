class SourceResult
  def self.call(env)
    [200, {'Content-Type' => 'text/html'}, File.open('index.html', File::RDONLY)]
  end

  if ENV['RACK_ENV'] == 'production'
    # See: https://newrelic.com/docs/ruby/rack-and-metal-support-in-the-ruby-agent
    require 'newrelic_rpm'
    require 'new_relic/agent/instrumentation/rack'
    extend ::NewRelic::Agent::Instrumentation::Rack
  end
end

use Rack::Deflater
run SourceResult

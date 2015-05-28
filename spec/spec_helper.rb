require 'bundler/setup'
Bundler.setup

require 'docker-run'
# and any other gems you need

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|

end

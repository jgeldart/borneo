require 'borneo'

require 'rspec/core'

RSpec.configure do |config|

  config.include Borneo::Mock::API

  config.before(:each) do
    Borneo::Client.enable_mocking!
  end

  config.after(:each) do
    Borneo::Client.reset_mocks!
  end

end

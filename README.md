# Borneo

Borneo makes working with Google's APIs as straightforward as navigating the jungle is
for an orangutan.

## Installation

Add this line to your application's Gemfile:

    gem 'borneo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install borneo

## Usage

The first step to using Borneo is to create a client. This client can be reused for
performance reasons. When creating the client, you should specify the client ID,
client secret and redirect URL:

    client = Borneo::Client.new(client_id, client_secret, redirect_url)

This client can then be authorised using an access token and refresh token that have
previously been obtained through an OAuth 2 exchange.

    api = client.for(access_token, refresh_token)

This object is the entry point to using all of Google's discoverable APIs. To access
a service, use the API's service method:

    plus = api.service('plus', 'v1')

The returned service object can then have methods called upon it:

    activities = plus.activities.list.call :userId => "me", :collection => "public"

The objects returned from the methods behave like normal Ruby objects:

    activities.items.each do |activity|
      puts activity.object.content
    end

Borneo raises an error if the operation wasn't permitted. If the access token is
stale, the library will try to refresh it once before raising an error.

## Mocking

To help test these services, you can switch the library into 'mocking mode' by:

    Borneo::Client.enable_mocking!

Before each test, you may want to clear the existing mock returns by calling:

    Borneo::Client.reset_mocks!

If you are using RSpec, both of these can be done by adding the following to your `spec_helper.rb`:

    require 'borneo/rspec'

Declaring a simple mock response can then be done as follows:

    Borneo::Client.stub_service('plus', 'v1').activities.list.to_return {:items => [ ... ]}

Using the RSpec helpers, this may also be simplified to:

    stub_service('plus', 'v1').activities.list.to_return {:items => [ ... ]}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

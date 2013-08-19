require 'rubygems'

begin
  # Only load if necessary
  require 'ruby-debug'
rescue LoadError
  # Do nothing
end

require 'rspec'
require 'webmock/rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'borneo')

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'materializer'
require 'support/dom'

RSpec.configure do |config|
  config.include DomSupport, dom: true
end

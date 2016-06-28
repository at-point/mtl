$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'mtl'
require 'support/dom'

RSpec.configure do |config|
  config.include DomSupport, dom: true
end

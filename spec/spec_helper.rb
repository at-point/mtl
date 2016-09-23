$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'mtl'
require 'support/dom'

# Configure simple form
require 'simple_form'
SimpleForm.setup do |config|
  config.wrappers :default do |b|
    b.use :input
    b.use :label
    b.optional :suffix
  end
end

RSpec.configure do |config|
  config.include DomSupport, dom: true
end

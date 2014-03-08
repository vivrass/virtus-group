require 'pry'
require 'virtus/group'

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"
end

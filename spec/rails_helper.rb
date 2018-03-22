require 'rails/all'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'spec_helper'
require 'rspec/rails'

Dir['./spec/pundit_kit/dummy/support/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include CurrentUserHelper, type: :controller
end

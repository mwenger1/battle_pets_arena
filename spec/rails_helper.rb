ENV["RAILS_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)

require "spec_helper"
require "rspec/rails"
require "shoulda/matchers"
require "webmock/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = false

  config.filter_gems_from_backtrace(
    "actionpack",
    "activerecord",
    "activesupport",
    "capybara",
    "rack",
    "rack-test",
    "railties",
    "spring-commands-rspec",
    "warden",
  )
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end

RSpec::Expectations.configuration.warn_about_potential_false_positives = false

ActiveRecord::Migration.maintain_test_schema!

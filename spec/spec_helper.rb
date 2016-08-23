$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if ENV.fetch("COVERAGE", false)
  require "simplecov"

  if ENV["CIRCLE_ARTIFACTS"]
    dir = File.join(ENV["CIRCLE_ARTIFACTS"], "coverage")
    SimpleCov.coverage_dir(dir)
  end

  if ENV['CODECLIMATE_REPO_TOKEN']
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter.start

    SimpleCov.formatters = [
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter
    ]
  end

  SimpleCov.configure do
    load_profile "test_frameworks"
  end

  SimpleCov.start
end

require 'transcript'

ENV["RAILS_ENV"] = "test"
require "rails/all"
require "dummy/config/environment"

require "shoulda-matchers"
require "factory_girl_rails"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  # config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.order = :random

  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model

  ActiveJob::Base.queue_adapter = :test
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

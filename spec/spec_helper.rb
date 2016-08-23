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

Dir[File.expand_path("../support/**/*.rb", __FILE__)].sort.each do |file|
  require_relative file
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.order = :random
end

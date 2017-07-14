$:.push File.expand_path("../lib", __FILE__)
require 'transcript/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency "ammeter", "~> 1.1"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.6"
  spec.add_development_dependency "factory_girl_rails", "~> 4.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "shoulda-matchers", "~> 3.1"
  spec.add_development_dependency "simplecov", "~> 0.12"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_runtime_dependency "rails", "~> 5.0"
  spec.authors = ["Logan Leger", "NewAperio"]
  spec.description = <<-DESC
Transcript is a simple audit library. It provides a clean interface for
recording changes to a given record, including metadata about the change itself.
  DESC
  spec.email = ["logan@newaperio.com", "hello@newaperio.com"]
  spec.files = `git ls-files -z`.split("\x0")
                                .reject { |f| f.match(%r{^(spec)/}) }
  spec.homepage = "https://github.com/newaperio/transcript"
  spec.license = "MIT"
  spec.name = "transcript"
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 1.9.3"
  spec.require_paths = ["lib"]
  spec.summary = "Simple ActiveRecord auditing."
  spec.test_files = `git ls-files -- spec/*`.split("\n")
  spec.version = Transcript::VERSION
end

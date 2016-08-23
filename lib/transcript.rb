require "transcript/actor"
require "transcript/configuration"
require "transcript/controller"
require "transcript/job"
require "transcript/model"
require "transcript/receiver"
require "transcript/version"

module Transcript
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end

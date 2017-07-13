require "active_support/concern"

module Transcript
  module Controller
    extend ActiveSupport::Concern

    def audit_action(actor, receiver, action = action_name)
      Transcript::Job.send(
        Transcript.configuration.job_method,
        actor, receiver, action
      )
    end
  end
end

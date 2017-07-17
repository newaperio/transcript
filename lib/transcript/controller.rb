require "active_support/concern"

module Transcript
  module Controller
    extend ActiveSupport::Concern

    def audit_action(actor, receiver, action = action_name, meta = nil)
      Transcript::Job.send(
        Transcript.configuration.job_method,
        actor, receiver, action, meta
      )
    end
  end
end

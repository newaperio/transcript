require "active_job"

module Transcript
  class Job < ActiveJob::Base
    queue_as :default

    def perform(actor, receiver, action)
      Transcript.configuration.audit_model.create(
        actor: actor,
        action: action,
        receiver: receiver,
        receiver_serialized: receiver,
      )
    end
  end
end

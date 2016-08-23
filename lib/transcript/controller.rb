require "active_support/concern"

module Transcript
  module Controller
    extend ActiveSupport::Concern

    def audit_action(actor, receiver, action = action_name)
      Transcript::Job.perform_later(actor, receiver, action)
    end
  end
end

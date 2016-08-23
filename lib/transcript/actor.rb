require "active_support/concern"

module Transcript
  module Actor
    extend ActiveSupport::Concern

    included do
      has_many :audit_entries_by,
        as: :actor,
        class_name: Transcript.configuration.audit_model
    end
  end
end

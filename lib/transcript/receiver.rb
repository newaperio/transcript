require "active_support/concern"

module Transcript
  module Receiver
    extend ActiveSupport::Concern

    included do
      has_many :audit_entries, as: :receiver
    end
  end
end

require "active_support/concern"

module Transcript
  module Model
    extend ActiveSupport::Concern

    included do
      belongs_to :actor, polymorphic: true
      belongs_to :receiver, polymorphic: true

      validates :actor, presence: true
    end

    module ClassMethods
      def latest
        order('created_at DESC').first
      end
    end
  end
end

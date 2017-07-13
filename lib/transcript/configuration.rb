module Transcript
  class Configuration
    CREATE_MODES = [:asynchronous, :synchronous]

    class UnsupportedCreateMode < StandardError; end

    attr_accessor :audit_model
    attr_reader :create_mode

    def initialize
      @create_mode = :synchronous
    end

    def create_mode=(mode)
      mode = mode.to_sym

      raise UnsupportedCreateMode unless CREATE_MODES.include?(mode)
      @create_mode = mode
    ensure
      @create_mode = :synchronous if @create_mode.nil?
    end

    def job_method
      create_mode.to_sym == :asynchronous ? :perform_later : :perform_now
    end
  end
end

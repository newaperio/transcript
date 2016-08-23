require 'rails/generators'

module Transcript
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def generate_model
      invoke "active_record:model", [
        name,
        "action:string",
        "actor:references{polymorphic}",
        "receiver:references{polymorphic}",
        "receiver_serialized:jsonb",
      ]
    end

    def generate_configuration_initializer
      template "transcript.rb.erb", "config/initializers/transcript.rb"
    end

    def add_model_concern
      inject_into_class "app/models/#{file_path}.rb",
        class_name,
        "  include Transcript::Model\n\n"
    end

    def add_controller_concern
      inject_into_class "app/controllers/application_controller.rb",
        "ApplicationController",
        "  include Transcript::Controller\n\n"
    end
  end
end

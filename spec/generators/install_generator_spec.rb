require "ammeter/init"
require "generators/transcript/install_generator"

RSpec.describe Transcript::InstallGenerator, type: :generator do
  before do
    destination File.expand_path("../../../tmp", __FILE__)
    prepare_destination
  end

  it "generates an audit model with the given name" do
    provide_existing_application_controller

    run_generator %w(audit_log)

    model = file("app/models/audit_log.rb")

    expect(model).to exist
    expect(model).to have_correct_syntax
  end

  it "includes the model concern in the generated model" do
    provide_existing_application_controller

    run_generator %w(audit_log)

    expect(file("app/models/audit_log.rb")).to contain(
      "include Transcript::Model"
    )
  end

  it "generates a configuration initializer" do
    provide_existing_application_controller

    run_generator %w(audit_log)

    initializer = file("config/initializers/transcript.rb")

    expect(initializer).to exist
    expect(initializer).to have_correct_syntax
    expect(initializer).to contain("config.audit_model = AuditLog")
  end

  it "includes the controller concern in ApplicationController" do
    provide_existing_application_controller

    run_generator %w(audit_log)

    controller = file("app/controllers/application_controller.rb")

    expect(controller).to exist
    expect(controller).to have_correct_syntax
    expect(controller).to contain("include Transcript::Controller")
  end

  def provide_existing_application_controller
    template_file = File.join(
      File.expand_path("../../support", __FILE__),
      "application_controller.rb"
    )
    destination = File.join(destination_root, "app/controllers")

    FileUtils.mkdir_p(destination)
    FileUtils.cp(template_file, destination)
  end
end

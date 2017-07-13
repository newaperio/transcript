RSpec.describe Transcript::Configuration do
  it "accepts a custom audit model" do
    config = Transcript::Configuration.new
    config.audit_model = AuditEntry

    expect(config.audit_model).to eq AuditEntry
  end

  it "has a default create mode" do
    config = Transcript::Configuration.new

    expect(config.create_mode).to eq :synchronous
    expect(config.job_method).to eq :perform_now
  end

  it "accepts a create mode option" do
    config = Transcript::Configuration.new
    config.create_mode = :asynchronous

    expect(config.create_mode).to eq :asynchronous
    expect(config.job_method).to eq :perform_later
  end

  it "raises an error if unsupported create mode is given" do
    config = Transcript::Configuration.new

    expect { config.create_mode = :foo }.to raise_error(
      Transcript::Configuration::UnsupportedCreateMode
    )
    expect(config.create_mode).to eq :synchronous
  end
end

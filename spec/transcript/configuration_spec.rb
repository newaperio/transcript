RSpec.describe Transcript::Configuration do
  it "accepts a custom audit model" do
    Transcript.configure { |config| config.audit_model = AuditEntry }

    expect(Transcript.configuration.audit_model).to eq AuditEntry
  end
end

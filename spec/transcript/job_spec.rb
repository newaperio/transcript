RSpec.describe Transcript::Job, type: :job do
  it "queues in the default queue" do
    expect(Transcript::Job.queue_name).to eq("default")
  end

  it "creates an audit entry for the given objects" do
    user = create(:user)
    post = create(:post)
    reference = "metadata"

    expect {
      Transcript::Job.perform_now(user, post, "edit", reference)
    }.to change(AuditEntry, :count).by(1)
  end
end

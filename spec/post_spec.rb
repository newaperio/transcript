RSpec.describe Post, type: :model do
  it "includes the model concern" do
    expect(Post.ancestors).to include Transcript::Receiver
  end

  describe "audit_entries has_many" do
    it { is_expected.to have_many(:audit_entries) }

    it "returns audit entries for a specific model" do
      post = create(:post)
      entries = create_list(:audit_entry, 2, receiver: post)
      create_list(:audit_entry, 2)

      expect(post.audit_entries).to match_array entries
    end
  end
end

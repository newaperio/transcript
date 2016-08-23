RSpec.describe User, type: :model do
  it "includes the model concern" do
    expect(User.ancestors).to include Transcript::Actor
  end

  describe "audit_entries_by has_many" do
    it { is_expected.to have_many(:audit_entries_by) }

    it "returns audit entries for a specific model" do
      user = create(:user)
      entries = create_list(:audit_entry, 2, actor: user)
      create_list(:audit_entry, 2)

      expect(user.audit_entries_by).to match_array entries
    end
  end
end

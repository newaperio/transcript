RSpec.describe AuditEntry, type: :model do
  it "includes the model concern" do
    expect(AuditEntry.ancestors).to include Transcript::Model
  end

  describe "schema" do
    it { is_expected.to have_db_column(:action).of_type(:string)              }
    # TODO This should be :jsonb, which doesn't work with SQLite
    it { is_expected.to have_db_column(:receiver_serialized).of_type(:string) }
    it { is_expected.to have_db_column(:receiver_id).of_type(:integer)        }
    it { is_expected.to have_db_column(:receiver_type).of_type(:string)       }
    it { is_expected.to have_db_column(:actor_id).of_type(:integer)           }
    it { is_expected.to have_db_column(:actor_type).of_type(:string)          }
    # TODO This should be :jsonb, which doesn't work with SQLite
    it { is_expected.to have_db_index([:actor_type, :actor_id])               }
    it { is_expected.to have_db_index([:receiver_type, :receiver_id])         }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:actor) }
  end

  describe "actor belongs_to" do
    it { is_expected.to belong_to(:actor) }

    it "returns the actor object that created the audit" do
      user = create(:user)
      entry = create(:audit_entry, actor: user)

      expect(entry.actor).to be_a User
      expect(entry.actor).to eq user
    end
  end

  describe "receiver belongs_to" do
    it { is_expected.to belong_to(:receiver) }

    it "returns the receiver object that created the audit" do
      post = create(:post)
      entry = create(:audit_entry, receiver: post)

      expect(entry.receiver).to be_a Post
      expect(entry.receiver).to eq post
    end
  end

  describe "#receiver_serialized" do
    it "returns the full receiver object" do
      post = create(:post)
      entry = create(:audit_entry, receiver: post)

      receiver = JSON.parse(entry.receiver_serialized)

      expect(receiver).to be_a Hash
      expect(Post.new(receiver)).to eq post
    end
  end

  describe "#latest" do
    it "returns the most recent audit entry" do
      audit_entry = create(:audit_entry)

      expect(described_class.latest).to eq(audit_entry)
    end
  end
end

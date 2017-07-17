FactoryGirl.define do
  factory :audit_entry do
    action "edit"
    receiver_serialized { (receiver || create(:post)).to_json }
    meta "metadata"
    association :receiver, factory: :post
    association :actor, factory: :user
  end

  factory :post do

  end

  factory :user do

  end
end

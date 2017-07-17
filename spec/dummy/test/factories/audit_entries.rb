FactoryGirl.define do
  factory :audit_entry do
    action "MyString"
    receiver_serialized ""
    receiver nil
    actor nil
    meta ""
    receiver_changes ""
  end
end

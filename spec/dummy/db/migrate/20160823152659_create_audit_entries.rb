class CreateAuditEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :audit_entries do |t|
      t.string :action
      t.references :actor, polymorphic: true
      t.references :receiver, polymorphic: true
      t.string :receiver_serialized

      t.timestamps
    end
  end
end

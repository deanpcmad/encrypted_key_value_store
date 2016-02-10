class CreateEncryptedKeyValueStoreTable < ActiveRecord::Migration
  
  def up
    create_table :encrypted_key_value_store do |t|
      t.integer :parent_id
      t.string  :parent_type
      t.string  :group
      t.string  :name
      t.text    :encrypted_value
      t.string  :value_type
    end
  end
  
  def down
    drop_table :encrypted_key_value_store
  end
  
end
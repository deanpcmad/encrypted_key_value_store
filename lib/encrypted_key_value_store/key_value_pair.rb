module EncryptedKeyValueStore
    
  class KeyValuePair < ActiveRecord::Base
    
    self.table_name = "encrypted_key_value_store"

    belongs_to :parent, polymorphic: true

    attr_encrypted :value, key: "abc123"

  end
  
end

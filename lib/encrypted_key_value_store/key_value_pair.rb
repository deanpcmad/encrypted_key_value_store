module EncryptedKeyValueStore
    
  class KeyValuePair < ActiveRecord::Base
    
    self.table_name = "encrypted_key_value_store"

    belongs_to :parent, polymorphic: true

    key = ENV["EKVS_KEY"] || Rails.application.secrets.secret_key_base

    attr_encrypted :value, key: key

  end
  
end

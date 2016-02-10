module EncryptedKeyValueStore
  class Railtie < Rails::Railtie
    
    initializer "encrypted_key_value_store.initialize" do

      ActiveSupport.on_load(:active_record) do
        require "encrypted_key_value_store/key_value_pair"
        require "encrypted_key_value_store/model_extension"
        ::ActiveRecord::Base.send :include, EncryptedKeyValueStore::ModelExtension
      end
      
    end
    
    generators do
      require "encrypted_key_value_store/migration_generator"
    end
    
  end
end
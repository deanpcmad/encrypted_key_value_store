module EncryptedKeyValueStore
  class Railtie < Rails::Railtie
    
    initializer "encrypted_key_value_store.initialize" do

      # Load the ActiveRecord extension
      ActiveSupport.on_load(:active_record) do
        require "encrypted_key_value_store/key_value_pair"
        require "encrypted_key_value_store/model_extension"
        ::ActiveRecord::Base.send :include, EncryptedKeyValueStore::ModelExtension
      end

      # Load the ActionView helpers
      ActiveSupport.on_load(:action_view) do
        require "encrypted_key_value_store/view_helpers"
        ActionView::Base.send :include, EncryptedKeyValueStore::ViewHelpers
      end
      
    end
    
    generators do
      require "encrypted_key_value_store/migration_generator"
    end
    
  end
end
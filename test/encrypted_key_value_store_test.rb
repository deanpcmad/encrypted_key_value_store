$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "encrypted_key_value_store"

require "minitest/autorun"
require "active_record"

require "encrypted_key_value_store/key_value_pair"
require "encrypted_key_value_store/model_extension"

include EncryptedKeyValueStore
include EncryptedKeyValueStore::ModelExtension

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

silence_stream(STDOUT) do
  ActiveRecord::Schema.define(:version => 1) do
    create_table :users do |t|
      t.string   :name
    end
    create_table :encrypted_key_value_store do |t|
      t.integer  :parent_id
      t.string   :parent_type
      t.string   :group
      t.string   :name
      t.text     :encrypted_value
    end
  end
end

class User < ActiveRecord::Base
  key_value_store :details
end




class EncryptedKeyValueStoreTest < Minitest::Test
  
  def test_that_it_has_a_version_number
    refute_nil ::EncryptedKeyValueStore::VERSION
  end

  def test_should_save_encrypted_values
    @kvp = KeyValuePair.create parent: User.create(name: "test"), name: "data", value: "test-value"
    assert @kvp.save

    refute_nil @kvp.encrypted_value

    refute_equal "test-value", @kvp.encrypted_value
  end

end

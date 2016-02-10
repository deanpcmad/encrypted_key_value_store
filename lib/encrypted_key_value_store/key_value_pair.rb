module EncryptedKeyValueStore
    
  class KeyValuePair < ActiveRecord::Base
    
    self.table_name = "encrypted_key_value_store"

    # Validations
    validates :group, presence: true
    validates :value, presence: true
    validates :value_type, presence: true

    belongs_to :parent, polymorphic: true

    before_validation do
      self.value_type = self.value.class.to_s
      self.value      = encoded_value
    end

    key = ENV["EKVS_KEY"] || Rails.application.secrets.secret_key_base
    attr_encrypted :value, key: key


    # The encoded value for saving in the backend (as a string)
    #
    # @return [String]
    def encoded_value
      case value_type
      when "Array", "Hash"  then  value.to_json
      when "Boolean"        then  value.to_s == "true" ? "true" : "false"
      else                        value.to_s
      end
    end

    # The decoded value for the setting attribute (in it's native type)
    #
    # @return [Object]
    def decoded_value
      case value_type
      when "Fixnum"         then  value.to_i
      when "Float"          then  value.to_f
      when "Date"           then  Date.parse(value)
      when "Array", "Hash"  then  JSON.parse(value)
      when "Boolean"        then  value == "true" ? true : false
      else                        value.to_s
      end
    end

    # A full hash of all settings available in the current scope
    #
    # @return [Hash]
    def self.to_hash
      all.inject({}) do |h, kv|
        h[kv.name] = kv.decoded_value
        h
      end
    end

  end
  
end

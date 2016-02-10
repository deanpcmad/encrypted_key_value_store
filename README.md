# EncryptedKeyValueStore 🔐

This is a gem to add a key/value store into your Rails app. The values are encrypted using a secret token of your choice. This gem uses the [attr_encrypted](https://github.com/attr-encrypted/attr_encrypted) gem for encryption.

To set the encryption key, set the `EKVS_KEY` environment variable with a random string (I like to use `SecureRandom.base64(50)` to generate one).

If the `EKVS_KEY` environment variable isn't set then the Rails `Rails.application.secrets.secret_key_base` will be used to encrypt the `value` field.

## Setup

Add the gem to the Gemfile

```ruby
gem 'encrypted_key_value_store'
```

And generate the database table

```bash
rails generate encrypted_key_value_store:migration
rake db:migrate
```

```ruby
class User < ActiveRecord::Base
  key_value_store :details
end

user = User.new
user.details   = {first_name: "Dean", last_name: "Perry"}
user.save

user.details   #=> {"first_name" => "Dean", "last_name" => "Perry"}
```

If you look the database, the value is encrypted in the `encrypted_value` column.

## Details

Please note that `true` and `false` are stored as strings in the database.

Some of this code is originally from [aTech Media](https://github.com/atech/nifty-key-value-store), but has been modified for encryption.
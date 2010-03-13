# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_food4feed_session',
  :secret      => '79a2de1586919ce3f9295b1129c6d777838e5922f67b02d903d50c6aaf628437e5ebabedacbe5740e6ffcb32ec1fe9115e369613e56d3d5f40242f7d2cbe3a8d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

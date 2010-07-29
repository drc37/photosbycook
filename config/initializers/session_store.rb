# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_photosbycookwebsite_session',
  :secret      => '6d3117eb3bf3cc64f24a66d0270f5f714c0268268888bdca83ae0a094983f46d3d129de9febba7fb9ec2f8b41df3c3b8eb0536e632bb32b0fd04a31cffee4194'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

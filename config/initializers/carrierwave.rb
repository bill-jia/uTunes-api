CarrierWave.configure do |config|
  # These permissions will make dir and files available only to the user running
  # the servers
  config.storage = :file
  # This avoids uploaded files from saving to public/ and so
  # they will not be available for public (non-authenticated) downloading
  config.root = Rails.root
end

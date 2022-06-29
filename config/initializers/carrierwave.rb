CarrierWave.configure do |config|
  config.storage = :grid_fs
  config.grid_fs_access_url   = '/images'
  # config.grid_fs_database     = Mongoid.default_client.options[:database]
end

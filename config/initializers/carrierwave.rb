require 'carrierwave/orm/activerecord'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     "AKIAJNG3O23TQ4UVVU7Q",                        # required
    aws_secret_access_key: "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",                        # required
    region:                'ap-northeast-2',             # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'nerozero'            # required
  config.asset_host = 'https://s3-ap-northeast-2.amazonaws.com/nerozero'
end

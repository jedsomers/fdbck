if Rails.env.production?
    CarrierWave.configure do |config|
        config.fog_credentials = {
            #configuration for amazon s3
            :provider => 'AWS',
            :aws_access_key_id => ENV['AKIAIPKXHFLVARZHVAQQ'],
            :aws_secret_access_key => ENV['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']
        }
        config.fog_directory = ENV['fdbck']
        
    end
end

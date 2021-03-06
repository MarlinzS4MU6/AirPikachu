require 'carrierwave'
require 'carrierwave/orm/activerecord'

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

CarrierWave.configure do |config|

  # Setups
  config.storage    =  :aws                  # required
  config.aws_bucket =  ENV['S3_BUCKET_NAME']      # required
  config.aws_acl    =  :public_read

  # API Creds
  config.aws_credentials = {
    access_key_id:      ENV['AWS_ACCESS_KEY_ID'],       # required
    secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],    # required
    region:             ENV['AWS_REGION']     # required
  }

  # Optionally define an asset host for configurations that are fronted by a
  # content host, such as CloudFront.
  # config.asset_host = 'http://example.com'

  # The maximum period for authenticated_urls is only 7 days.
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching
  config.aws_attributes = {
    cache_control: "max-age=#{365.day.to_i}",
    expires: 1.year.from_now.httpdate
   }

end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tech_crawler'
require 'vcr'

VCR.configure do |config|
  config.default_cassette_options = {
    record: :new_episodes, re_record_interval: (72 * 3600) # 3 days
  }
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :typhoeus
  config.configure_rspec_metadata!
end

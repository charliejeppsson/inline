$redis = Redis.new

ENV["REDISCLOUD_URL"] = "redis://rediscloud:OatJVPhFgyVtQdRZ@redis-17928.c2.eu-west-1-3.ec2.cloud.redislabs.com:17928"
url = ENV["REDISCLOUD_URL"]

if url
  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
  $redis = Redis.new(:url => url)
end

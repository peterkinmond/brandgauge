if Rails.env == "production"
  if ENV["REDISTOGO_URL"]
    uri = URI.parse(ENV['REDISTOGO_URL']) 
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  else
    puts "Could Not connect to REDIS you might have problems"
  end
else
  $redis = Redis.new
  $redis.ping
end

def Rails.redis
  $redis
end


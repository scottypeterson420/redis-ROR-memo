require 'database_cleaner/active_record'

RSpec.configure do |config|
  require 'active_record'
  require 'redis_memo'

  config.before(:all) do
    ActiveRecord::Base.establish_connection(
      :adapter  => ENV['RSPEC_DB_ADAPTER'] || 'postgresql',
      :host     => 'localhost',
      :username => ENV['RSPEC_DB_USERNAME'] || 'postgres',
      :password => ENV['RSPEC_DB_PASSWORD'] || '',
      :database => 'redis_memo_test',
    )
  end

  config.before(:each) do
    RedisMemo::Cache.redis.flushdb
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

require 'sequel'

DB = nil
MAX_ATTEMPTS = 10
WAIT_TIME = 2 # seconds

MAX_ATTEMPTS.times do |i|
  begin
    DB = Sequel.connect('mongodb://admin_user:admin_pass@mongodb:27017/database')
    puts "✅ Connected to MongoDB"
    break
  rescue Sequel::DatabaseConnectionError => e
    puts "⏳ Attempt #{i + 1}/#{MAX_ATTEMPTS}: Database not available (#{e.message})"
    sleep WAIT_TIME
  end
end

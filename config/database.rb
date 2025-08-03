require 'sequel'

DB = nil
MAX_ATTEMPTS = 10
WAIT_TIME = 2 # sekundy

MAX_ATTEMPTS.times do |i|
  begin
    DB = Sequel.connect('postgres://postgres:postgres@db:5432/ruby_app_dev')
    puts "✅ Połączono z bazą danych"
    break
  rescue Sequel::DatabaseConnectionError => e
    puts "⏳ Próba #{i+1}/#{MAX_ATTEMPTS}: baza niedostępna (#{e.message})"
    sleep WAIT_TIME
  end
end

raise "❌ Nie udało się połączyć z bazą po #{MAX_ATTEMPTS} próbach" unless DB

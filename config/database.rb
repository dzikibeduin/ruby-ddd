require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/my_database')

require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://ruby_user:ruby_pass@localhost:5432/ruby_app_dev')

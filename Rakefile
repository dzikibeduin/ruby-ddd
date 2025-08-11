require 'sequel'
require_relative './config/database'

namespace :db do
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'infrastructure/db/migrate')
    puts "Database migration completed successfully."
  end
end

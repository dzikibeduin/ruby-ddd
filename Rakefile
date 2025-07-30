require 'sequel'
require_relative './config/database'

namespace :db do
  task :migrate do
    Sequel.extenstion :migration
    Sequel::Migrator.run(DB, 'infrastucture/db/migrate')
    puts "Database migration completed successfully."
  end
end

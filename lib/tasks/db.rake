namespace :db do
  namespace :dev do
    desc "Delete all data in all tables in the development database"
    task :delete_all => :environment do
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.execute("TRUNCATE #{table}") unless table == 'schema_migrations'
      end
    end

    desc "DROP ALL TABLES in the development database"
    task :drop_all_tables => :environment do
      ActiveRecord::Base.connection.tables.each do |table|
        ActiveRecord::Base.connection.execute("DROP #{table}") 
      end
    end
  end
end
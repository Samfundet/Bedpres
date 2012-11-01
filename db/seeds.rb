# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def interesting_tables
  ActiveRecord::Base.connection.tables.sort.reject do |tbl|
    ['schema_migrations', 'sessions', 'public_exceptions'].include?(tbl)
  end
end

def truncate_db_table(table)
  config = ActiveRecord::Base.configurations[Rails.env]
  ActiveRecord::Base.establish_connection
  case config["adapter"]
    when "mysql", "postgres"
      ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
    when "sqlite", "sqlite3"
      ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
      ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='#{table}'")
      ActiveRecord::Base.connection.execute("VACUUM")
  end
end

interesting_tables.each do |table|
  truncate_db_table table
end

Rake::Task['samfundet_auth_engine:db:seed'].invoke

puts "Creating presentations.."

10.times do
  Presentation.create!(
      :name => Faker::Lorem.words(3).join(" "),
      :area_id => Area.all.sample.id,
      :guest_limit => 1 + rand(999),
      :presentation_date => Time.now + (1+rand(9)).days,
      :description => Faker::Lorem.paragraphs.join("\n\n")
  )
end

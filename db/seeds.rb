# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

Rake::Task['samfundet_auth_engine:db:seed'].invoke

puts "Creating presentations.."

presentations = 10

presentations.times do
  Presentation.create!(
      :name => Faker::Lorem.words(3).join(" "),
      :corporation => Faker::Company.name,
      :area_id => Area.all.sample.id,
      :guest_limit => 1 + rand(999),
      :presentation_date => Time.now + (1+rand(9)).days,
      :description => Faker::Lorem.paragraphs.join("\n\n")
  )
end

puts "Creating users and participations"

users = 7

Presentation.all.each do |p|
  users.times do 
    u = User.create!(
      :firstname => Faker::Name.first_name, 
      :surname => Faker::Name.last_name,
      :email => Faker::Internet.email,
      :password => "passord",
      :password_confirmation => "passord"
    )
    puts "Registering #{u.full_name} for #{p.name}"
    Participation.create!(:participle => u, :presentation => p)
  end
end

puts "Creating named- and easy to remember user: bruker@samfundet.no !"

User.create!(
  :firstname => "Bruker",
  :surname => "Brukerson",
  :email => "bruker@samfundet.no",
  :password => "passord",
  :password_confirmation => "passord"
)

namespace :db do
  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
    50.times { Lead.create!(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, location: Faker::Address.city, user_id: 1, department_id: 1) }
    50.times { Lead.create!(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, location: Faker::Address.city, user_id: 1, department_id: 5) }
    50.times { Contact.create!(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, user_id: 8, department_id: 1, source: 'Интернет', region: 'Хмельницкий', assigned_to: 8) }
    50.times { Contact.create!(name: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email, user_id: 7, department_id: 5, source: 'Интернет', region: 'Винница', assigned_to: 7) }
  end
end

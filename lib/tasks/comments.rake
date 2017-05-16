namespace :db do
  desc 'Populates the database with comments'
  task populate_sample_comments: :environment do
    Contact.where(department_id: 1).each { |contact| contact.comments.create!(user_id: 1, body: Faker::Lorem.sentence(3, true, 4)) }
    Contact.where(department_id: 5).each { |contact| contact.comments.create!(user_id: 1, body: Faker::Lorem.sentence(3, true, 4)) }
  end
end


require 'csv'

namespace :import do

  desc "Import contacts from csv"
  task contacts: :environment do
    filename = File.join Rails.root, 'contacts.csv'
    counter = 0
    comments_counter = 0
    CSV.foreach(filename, headers:true) do |row|
      comments_arrays = CSV.read(File.join Rails.root, 'comments.csv')
      contact = Contact.create(created_at: Date.parse(row["Created at"]),
                               region: row["Cf   4"].blank? ? 'Неизвестно' : row["Cf   4"],
                               floor: row["Cf   11"],
                               updated_at: Date.parse(row["Updated at"]),
                               name: (row["Last name"].blank? ? row["First name"] : row["First name"] + " " + row["Last name"]),
                               source: row["Cf   9"].blank? ? 'Интернет' : row["Cf   9"],
                               status: row["Cf   5"] == 'true' ? 'sended' : 'finished',
                               project: row["Cf   2"],
                               square: row["Cf   3"],
                               location: row["Cf"],
                               phone_call: row["Cf   6"],
                               online_request: row["Cf   7"],
                               come_in_office: row["Cf   8"],
                               user_id: row["User"].blank? ? (row["Assigned to"].blank? ? '1' : row["Assigned to"]) : row["User"],
                               assigned_to: row["Assigned to"].blank? ? (row["User"].blank? ? '2' : row["User"]) : row["Assigned to"],
                               phone: row["Phone"].blank? ? "Нет" : row["Phone"],
                               email: row["Email"],
                               do_not_call: row["Do not call"] == 'false' ? false : true,
                               department_id: row["Cf   4"].blank? ? '1' : (row["Cf   4"].mb_chars.downcase.include?('вин') ? '2' : '1'))
      
      # import comments in Contact#custom field
      if !row["Cf   12"].blank?
        com1 = Comment.create(user_id: row["Assigned to"], commentable_id: contact.id, commentable_type:"Contact", body: row["Cf   12"], created_at: contact.created_at)
        if com1.errors.any?
          open('import_error.log', 'w') do |f|
            f << "Comment for contact id - #{com1.commentable_id} have error - #{com1.errors.full_messages.join(",")}\n"
          end
        end
        comments_counter += 1 if com1.persisted?
      end

      # import comments added by users
      comments_arrays.each do |comment|
        if row["Id"] == comment[2]
          com2 = contact.comments.create(user_id: comment[1], body: comment[4], created_at: comment[5])
          # Comment.create(user_id: comment[1], commentable_id: comment[2], commentable_type: 'Contact', body: comment[4], created_at: comment[5])
          if com2.errors.any?
            open('import_error.log', 'w') do |f|
              f << "Comment for contact id - #{com2.commentable_id} have error - #{com2.errors.full_messages.join(",")}\n"
            end
          end
          comments_counter += 1 if com2.persisted?
        end
      end

      if contact.errors.any?
        # puts "#{contact.email} - #{contact.errors.full_messages.join(",")}" 
        open('import_error.log', 'w') do |f|
          f << "#{contact.email} - #{contact.errors.full_messages.join(",")}\n"
        end
      end
      counter += 1 if contact.persisted?
      p row
    end
    puts "Imported #{counter} contacts and #{comments_counter} comments"
  end
end
require 'csv'
namespace :export do
  desc 'Export Servus Khmelnitsky comments'
  task km_comments: :environment do
    CSV.open('km_comments.csv','w') do |csv|
      Comment.where(created_at: 10.months.ago..Time.current).each_with_index do |comment, index|
        if comment.commentable.present? && comment.commentable.department_id == 1
          puts "done #{index}"
          csv << [comment.body]
        end
      end
    end
  end

  desc 'Export Servus Vinnitsa comments'
  task vn_comments: :environment do
    CSV.open('vn_comments.csv','w') do |csv|
      Comment.where(created_at: 10.months.ago..Time.current).each_with_index do |comment, index|
        if comment.commentable.present? && comment.commentable.department_id == 2
          puts "done #{index}"
          csv << [comment.body]
        end
      end
    end
  end
end

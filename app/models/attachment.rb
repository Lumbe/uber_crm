class Attachment < ApplicationRecord
  belongs_to :message
  has_attached_file :attachment

  validates_attachment_file_name :attachment, matches: %r{\.(docx|doc|odf|otf|pdf|xls|xlsx|zip|7z|rar|jpeg|jpg|png|gif|tiff|tif)\z}i, message: "Данный тип файла не поддерживается"
end

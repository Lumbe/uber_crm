class Attachment < ApplicationRecord
  ALLOWED_FORMATS = %w(txt docx doc odf otf pdf xls xlsx zip 7z rar jpeg jpg png gif tiff tif)

  belongs_to :message, inverse_of: :attachments
  has_attached_file :attachment

  validates_attachment_file_name :attachment, matches: /\.(#{ALLOWED_FORMATS.join('|')})\z/i,
    message: "Данный тип файла не поддерживается. Можно вложить только файлы формата: #{ALLOWED_FORMATS.join(', ')}."

end

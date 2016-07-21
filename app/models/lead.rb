class Lead < ActiveRecord::Base
    
    validates :name, presence: true
    validates :phone, presence: true
    
    enum status: [:newly, :closed, :converted, :sended, :repeated]
    
end

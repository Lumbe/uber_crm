module Effective
  module Datatables
    class Leads < Effective::Datatable
      datatable do
        default_order :created_at, :desc

        table_column :status, sortable: false, label: 'Статус', filterable: false, filter: false do |lead|
          format_status_label(lead)
        end
        table_column :name, label: 'Имя', sortable: false, :proc => Proc.new { |lead| link_to(lead.name, lead_path(lead)) }
        table_column :phone, label: 'Телефон', sortable: false
        table_column :email, sortable: false
        table_column :region, label: 'Регион'
        table_column :created_at, label: 'Добавлен',filter: false, :proc => Proc.new { |lead| time_ago_in_words(lead.created_at) + " назад" }
        actions_column partial: 'leads/actions'
        # table_column :user      # if Post belongs_to :user
        # table_column :comments  # if Post has_many :comments
      end
      
      def collection
        Lead.all
      end
      
      # def search_column(collection, table_column, search_term, sql_column)
      #   if table_column[:name] == 'subscription_types'
      #     collection.where('subscriptions.stripe_plan_id ILIKE ?', "%#{search_term}%")
      #   else
      #     super
      #   end
      # end
      
      def format_status_label(lead)
        case lead.status
        when 'newly'
          "<span class='label label-warning'>Новый</span>"
          # %span.label.label-warning Новый
        when 'repeated'
          "<span class='label label-warning'>Повторно</span>"
        when 'closed'
          "<span class='label label-default'>Закрыт</span>"
        when 'converted'
          "<span class='label label-success'>Конверитрован</span>"
        when 'sended'
          "<span class='label label-info'>Передан в ГО</span>"
        end
      end
      
    end
  end
end
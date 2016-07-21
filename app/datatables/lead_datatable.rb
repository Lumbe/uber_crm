class LeadDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['Lead.status',
                          'Lead.created_at',
                          'Lead.region']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['Lead.name', 'Lead.phone', 'Lead.email', 'Lead.region']
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.status,
        record.name,
        record.phone,
        record.email,
        record.region,
        record.created_at
      ]
    end
  end

  def get_raw_records
    # insert query here
    Lead.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end

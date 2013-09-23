class MailingList < ActiveRecord::Base
  self.table_name = "mailing_list"
  attr_accessible :email, :name, :dob

  def self.to_csv(options = {})

    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |mailing_list_item|
        csv << mailing_list_item.attributes.values_at(*column_names)
      end
    end
  end
end

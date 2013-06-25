# This migration comes from refinery_mailchimp (originally 2)
class RemoveToNameFromMailchimpCampaigns < ActiveRecord::Migration

  def up
    remove_column :refinery_mailchimp_campaigns, :to_name
  end

  def down
    add_column :refinery_mailchimp_campaigns, :to_name, :string
  end

end
class CreateMailingList < ActiveRecord::Migration
  def up
    create_table :mailing_list do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :mailing_list
  end
end

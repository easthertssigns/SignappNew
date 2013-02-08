class AddDeletedByUserAndDeletedByAdminToSignData < ActiveRecord::Migration
  def change
    add_column :sign_data, :deleted_by_user, :boolean
    add_column :sign_data, :deleted_by_admin, :boolean
  end
end

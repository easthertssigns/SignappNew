Refinery::User.class_eval do
  def get_saved_signs
    SignData.where("account_id = ?", id)
  end
end


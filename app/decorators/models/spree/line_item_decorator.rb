Spree::LineItem.class_eval do

  def sign_data
    if sign_data_id
      SignData.find(sign_data_id)
    end
  end

end

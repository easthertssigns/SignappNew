Spree::Order.class_eval do
  def full_name
    full_name = ""
    unless bill_address.nil?
      full_name = bill_address.firstname

       unless bill_address.lastname.nil?
         full_name += " " + bill_address.lastname
       end
    end

    full_name
  end
end

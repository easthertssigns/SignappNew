module ApplicationHelper
   def get_current_order
     return @current_order if @current_order
     if session[:order_id]
       current_order = Spree::Order.find_by_id(session[:order_id], :include => :adjustments)
       @current_order = current_order unless current_order.try(:completed?)
     end
     @current_order
     #order = nil
     #unless session[:order_id].nil?
     #   order = Spree::Order.find(session[:order_id])
     #end
     #order
   end

   def account_logged_in
       # check for session user_id
       if session[:account_id]
         true
       else
         false
       end
     end

   def get_line_items
         if order.complete? and Spree::Config[:track_inventory_levels]
           order.line_items.select { |li| inventory_units.map(&:variant_id).include?(li.variant_id) }
         else
           order.line_items
         end
   end


   def get_home_page_slides
     @slides = Refinery::HomePageSliders::HomePageSlider.order('position ASC').where(:display => true)
   end

   def get_product_list_for_menu
     @product = Spree::Product.where(:show_in_menu => true).limit(1).first
   end

end

module Spree
  module Admin
    class CustomSignController < Spree::Admin::ResourceController
      before_filter :check_json_authenticity, :only => :index
      before_filter :load_data, :except => :index
      create.before :create_before
      update.before :update_before

      def index
        respond_with(@collection) do |format|
          format.html
          format.json { render :json => json_data }
        end
      end
    end
  end
end
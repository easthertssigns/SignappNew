module Spree
  module Admin
    class SignSizeController < ApplicationController
      helper "spree/admin/navigation"
      layout "spree/layouts/admin"

      def index
        @sign_sizes = SignSize.all
        #raise @sign_sizes.to_yaml
      end

      def new
        @sign_size = SignSize.new
      end

      def create
        @sign_size = SignSize.new
        @sign_size.update_attributes(params[:sign_size])
        @sign_size.save
        redirect_to "/admin/sign_size"
      end

      def edit
        @sign_size = SignSize.find params[:id]
      end

      def update
        @sign_size = SignSize.find params[:id]
        @sign_size.update_attributes(params[:sign_size])
        redirect_to "/admin/sign_size"
      end

      def show
        @sign_size = SignSize.find params[:id]
      end

    end
  end
end

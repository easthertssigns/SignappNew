module Spree
  module Admin
    class SignShapeController < ApplicationController
      helper "spree/admin/navigation"
      layout "spree/layouts/admin"

      def index
        @sign_base_shapes = SignBaseShape.all()
      end

      def new
        @sign_base_shape = SignBaseShape.new
      end

      def create
        @sign_base_shape = SignBaseShape.new
        @sign_base_shape.update_attributes(params[:sign_base_shape])
        @sign_base_shape.save

        SignSize.all.each do |size|
          if params["sign_size_#{size.id}"]
            @sign_base_shape.add_size_if_not_added(size)
          end
        end

        redirect_to "/admin/sign_shape"
      end

      def edit
        @sign_base_shape = SignBaseShape.find params[:id]
      end

      def update
        #update the categories here - do I just delete them all and add new records every time, or do some sort of check?
        @sign_base_shape = SignBaseShape.find params[:id]
        @sign_base_shape.update_attributes(params[:sign_base_shape])

        SignSize.all.each do |size|
          if params["sign_size_#{size.id}"]
            @sign_base_shape.add_size_if_not_added(size)
          else
            @sign_base_shape.remove_size_if_added(size)
          end
        end

        redirect_to "/admin/sign_shape"
      end

      def destroy
        @sign_base_shape = SignBaseShape.find params[:id]
        #SignGraphicToCategory.delete_all(["sign_graphic_id = ?", params[:id]])
        @sign_base_shape.svg_file.destroy
        @sign_base_shape.svg_file.clear
        @sign_base_shape.destroy
        redirect_to "/admin/sign_shape"
      end
    end
  end
end



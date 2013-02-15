module Spree
  module Admin
    class SignGraphicsController < ApplicationController
      helper "spree/admin/navigation"
      layout "spree/layouts/admin"

      def index
        @graphics = SignGraphic.paginate(:page => params[:page])
      end

      def new
        @graphic = SignGraphic.new
      end

      def create
        @graphic = SignGraphic.new
        @graphic.update_attributes(params[:sign_graphic])
        @graphic.save
        redirect_to "/admin/sign_graphics"
      end

      def edit
        @graphic = SignGraphic.find params[:id]
        all_categories = SignGraphicCategory.all
        selected_categories = SignGraphicToCategory.all(:conditions => ["sign_graphic_id = ?", params[:id]])
        @categories_for_graphic = []
        all_categories.each do |c|
          selected = false
          selected_categories.each do |s|
            if s.sign_graphic_category_id.to_i == c.id.to_i
              selected = true
              break
            end
          end
          category = {
              :id => c.id,
              :name => c.category_name,
              :description => c.category_description,
              :selected => selected
          }
          @categories_for_graphic << category
        end
      end

      def show
        @graphic = SignGraphic.find params[:id]
        all_categories = SignGraphicCategory.all
        selected_categories = SignGraphicToCategory.all(:conditions => ["sign_graphic_id = ?", params[:id]])
        @categories_for_graphic = []
        all_categories.each do |c|
          selected = false
          selected_categories.each do |s|
            if s.sign_graphic_category_id.to_i == c.id.to_i
              selected = true
              category = {
                  :id => c.id,
                  :name => c.category_name,
                  :description => c.category_description,
                  :selected => selected
              }
              @categories_for_graphic << category
              break
            end
          end
        end
      end

      def update
        #update the categories here - do I just delete them all and add new records every time, or do some sort of check?
        SignGraphicToCategory.delete_all(["sign_graphic_id = ?", params[:id]])
        if params[:category]
          params[:category][:category_id].each do |c|
            category_id =  c[0]
            sgtc = SignGraphicToCategory.new
            sgtc.sign_graphic_category_id = category_id
            sgtc.sign_graphic_id = params[:id]
            sgtc.save
          end
        end
        @graphic = SignGraphic.find params[:id]
        @graphic.update_attributes(params[:sign_graphic])
        redirect_to "/admin/sign_graphics"
      end

      def destroy
        graphic = SignGraphic.find params[:id]
        SignGraphicToCategory.delete_all(["sign_graphic_id = ?", params[:id]])
        graphic.svg_file.destroy
        graphic.svg_file.clear
        graphic.destroy
        redirect_to "/admin/sign_graphics"
      end
    end
  end
end



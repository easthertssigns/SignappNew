module Spree
  module Admin
    class SignProductsController < ApplicationController
      helper "spree/admin/navigation"
      helper 'spree/admin/base'
      layout "spree/layouts/admin"

      def index
        @products = Spree::Product.all(:conditions => ["is_product = ? AND deleted_at IS NULL", true])
      end

      def show
        @product = Spree::Product.first(:conditions => ["permalink = ? AND is_product = ? AND deleted_at IS NULL", params[:id], true])
        if !@product
          render :layout => "product_not_found"
        end
      end

      def new
        @product = Spree::Product.new
      end

      def create

        require "open-uri"
        #sign_data_id is for the original sign_data record
        #this needs to be duplicated to a new sign_data record
        #then a new product is created with the




        sign_data = SignData.find params[:sign_data_id]

        new_sign_data = SignData.new


        new_sign_data.account_id = 1 #this wants fixing at some point
        new_sign_data.description = sign_data.description
        new_sign_data.height = sign_data.height
        new_sign_data.name = sign_data.name
        new_sign_data.price = sign_data.price
        new_sign_data.shape_id = sign_data.shape_id
        new_sign_data.sign_data = sign_data.sign_data
        new_sign_data.spree_product_id = sign_data.spree_product_id
        new_sign_data.width = sign_data.width
        new_sign_data.image = open(sign_data.image.url)

        new_sign_data.canvas_height = sign_data.canvas_height
        new_sign_data.canvas_width = sign_data.canvas_width
        new_sign_data.canvas_scale = sign_data.canvas_scale

        new_sign_data.save

        @product = Spree::Product.new
        @product.sign_data_id = new_sign_data.id

        #@product.name = new_sign_data.name
        #if @product.name.blank?
          @product.name = "NEW PRODUCT FROM SIGN"
        #end

        @product.description = new_sign_data.description
        @product.available_on = Time.now
        @product.is_product = true
        @product.is_material = false
        @product.is_featured = false
        @product.price = new_sign_data.price
        @product.is_master = true
                                     #raise @product.to_yaml
        unless @product.save
          raise @product.errors.to_yaml
        end
                                     #how to set the taxonomy? Try this first and see what happens though
        redirect_to "/admin/products/#{@product.permalink}/edit"
      end

      def create_var
        #raise params.to_yaml

        # validation checks


        require "open-uri"
        #sign_data_id is for the original sign_data record
        #this needs to be duplicated to a new sign_data record
        #then a new product is created with the

        if params[:parent_id].blank?
          redirect_to "/admin/sign_data/#{params[:sign_data_id]}", :alert => "No Product Selected as parent product"
        else
          sign_data = SignData.find params[:sign_data_id]

          new_sign_data = SignData.new
          new_sign_data.account_id = 1 #this wants fixing at some point
          new_sign_data.description = sign_data.description
          new_sign_data.height = sign_data.height
          new_sign_data.name = sign_data.name
          new_sign_data.price = sign_data.price
          new_sign_data.shape_id = sign_data.shape_id
          new_sign_data.sign_data = sign_data.sign_data

          new_sign_data.width = sign_data.width
          new_sign_data.image = open(sign_data.image.url)

          new_sign_data.canvas_height = sign_data.canvas_height
          new_sign_data.canvas_width = sign_data.canvas_width
          new_sign_data.canvas_scale = sign_data.canvas_scale

          new_sign_data.save

          @product = Spree::Product.new
          @product.parent_id = params[:parent_id]

          @product.sign_data_id = new_sign_data.id

          #@product.name = new_sign_data.name
          #if @product.name.blank?
          @product.name = "NEW PRODUCT FROM SIGN"
          #end

          @product.description = new_sign_data.description
          @product.available_on = Time.now
          @product.is_product = true
          @product.is_material = false
          @product.is_featured = false
          @product.price = new_sign_data.price
          @product.is_master = true
          #raise @product.to_yaml
          unless @product.save
            raise @product.errors.to_yaml
          end

          new_sign_data.spree_product_id = @product.id
          new_sign_data.save

          #how to set the taxonomy? Try this first and see what happens though
          redirect_to "/admin/products/#{@product.permalink}/edit"
        end


      end

      def edit
        @product = Spree::Product.first(:conditions => ["permalink = ?", params[:id]])
        if @product.nil? || !@product.is_product
          redirect_to "/admin/sign_products/product_not_found"
        end
      end

      def update
        @product = Spree::Product.find params[:id]
      end

      def product_not_found

      end
    end
  end
end
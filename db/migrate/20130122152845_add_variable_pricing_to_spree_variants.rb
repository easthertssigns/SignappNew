class AddVariablePricingToSpreeVariants < ActiveRecord::Migration
  def change
    add_column :spree_variants, :small_size_price, :decimal
    add_column :spree_variants, :large_size_price, :decimal
    add_column :spree_variants, :small_size_threshold, :integer
    add_column :spree_variants, :large_size_threshold, :integer
    add_column :spree_variants, :minimum_width, :integer
    add_column :spree_variants, :maximum_width, :integer
    add_column :spree_variants, :minimum_height, :integer
    add_column :spree_variants, :maximum_height, :integer
  end
end

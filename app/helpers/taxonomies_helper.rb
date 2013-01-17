module TaxonomiesHelper
  def get_taxonomies
    @taxonomies ||= Spree::Taxonomy.includes(:root => :children).joins(:root)
  end


  def taxons_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    #content_tag :ul, :class => 'taxons-list' do
    root_taxon.children.map do |taxon|
      css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
      content_tag :li, :class => css_class do
        link_to(taxon.name, seo_url(taxon)) +
            taxons_tree(taxon, current_taxon, max_level - 1)
      end
    end.join("\n").html_safe
    #end
  end

  # generates nested url to product based on supplied taxon
  def seo_url(taxon, product = nil)
    return spree.nested_taxons_path(taxon.permalink) if product.nil?
    warn "DEPRECATION: the /t/taxon-permalink/p/product-permalink urls are "+
             "not used anymore. Use product_url instead. (called from #{caller[0]})"
    return product_url(product)
  end

  def get_products(taxon)
    @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => taxon.id))
    @searcher.retrieve_products
  end


end

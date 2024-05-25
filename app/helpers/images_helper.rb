# frozen_string_literal: true

module ImagesHelper
  def variant_selection(product)
    variants(product).unshift(['All', nil])
  end

  private

  def variants(product)
    variants = product.non_master_variants.sort_by_position.grouped_option_name

    variants.map do |v|
      [v.grouped_name, v.id]
    end
  end
end

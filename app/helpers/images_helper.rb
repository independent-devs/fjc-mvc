# frozen_string_literal: true

module ImagesHelper
  def image_variant_selection(product)
    selections(product).unshift(['All', nil])
  end

  def selections(product)
    variants = product.non_master_variants.sort_by_position.not_deleted.with_grouped_name

    variants.map do |v|
      [v.grouped_name, v.id]
    end
  end
end

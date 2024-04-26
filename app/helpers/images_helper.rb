# frozen_string_literal: true

module ImagesHelper
  def image_variant_selection(product)
    selections(product).unshift(['All', nil])
  end

  def selections(product)
    variants = product.non_master_variants
                      .not_deleted.sort_by_position

    variants.map do |v|
      [v.name, v.id]
    end
  end
end

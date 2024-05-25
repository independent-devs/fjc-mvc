# frozen_string_literal: true

module ProductsHelper
  def pub_stock_num(product)
    return product.variants.not_master.stock_sum if product.has_variant

    product.master_variant.count_on_hand
  end

  def pub_variant_uuid(product)
    return '' if product.has_variant

    product.master_variant.uuid
  end
end

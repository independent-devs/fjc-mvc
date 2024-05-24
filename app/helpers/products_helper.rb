# frozen_string_literal: true

module ProductsHelper
  def pub_product_stock_num(product)
    return product.variants.not_master.stock_sum if product.has_variant

    product.master_variant.count_on_hand
  end

  def pub_product_variant(product)
    return '' if product.has_variant

    product.master_variant.uuid
  end
end

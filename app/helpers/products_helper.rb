# frozen_string_literal: true

module ProductsHelper
  def currency_list
    Money::Currency.table.map do |cu|
      ["#{cu[1][:iso_code]} (#{cu[1][:symbol]})", cu[1][:iso_code]]
    end
  end

  def pub_stock_num(product)
    return product.variants.not_master.stock_sum if product.has_variant

    product.master_variant.count_on_hand
  end

  def pub_variant_uuid(product)
    return '' if product.has_variant

    product.master_variant.uuid
  end
end

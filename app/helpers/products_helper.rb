# frozen_string_literal: true
# typed: true

module ProductsHelper
  extend T::Sig

  def currency_list
    Money::Currency.table.map do |cu|
      ["#{cu[1][:iso_code]} (#{cu[1][:symbol]})", cu[1][:iso_code]]
    end
  end

  sig { params(product: Product).returns(T.any(Integer, Float, BigDecimal)) }
  def pub_stock_num(product)
    return product.variants.not_master.sum(:count_on_hand) if product.has_variant

    T.must(product.master_variant).count_on_hand
  end

  sig { params(product: Product).returns(String) }
  def pub_variant_uuid(product)
    return '' if product.has_variant

    T.must(product.master_variant).id
  end
end

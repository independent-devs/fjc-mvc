# frozen_string_literal: true

class ProductComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :product

  sig { params(product: Product).void }
  def initialize(product:)
    @product = product
    super
  end
end

# frozen_string_literal: true
# typed: true

class StarRatingComponent < ViewComponent::Base
  extend T::Sig

  attr_reader :stars, :rating

  sig { params(stars: Integer, rating: T.any(Integer, Float, BigDecimal)).void }
  def initialize(stars: 5, rating: 0)
    @stars = stars
    @rating = rating
    super
  end

  sig { returns(T.any(Float, BigDecimal)) }
  def percentage
    rating.to_f / stars * 100.0
  end
end

# frozen_string_literal: true

class StarRatingComponent < ViewComponent::Base
  attr_reader :stars, :rating

  def initialize(stars: 5, rating: 0)
    @stars = stars
    @rating = rating
    super
  end

  def percentage
    rating.to_f / stars * 100.0
  end
end

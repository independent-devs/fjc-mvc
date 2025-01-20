# frozen_string_literal: true

class Description < ApplicationRecord
  belongs_to :product, touch: true
end

# == Schema Information
#
# Table name: descriptions
#
#  id          :uuid             not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :uuid             not null
#
# Indexes
#
#  index_descriptions_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#

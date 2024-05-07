# frozen_string_literal: true

class ProductOption < ApplicationRecord
  # Relations
  belongs_to :product
  belongs_to :option
end

# == Schema Information
#
# Table name: product_options
#
#  id         :bigint           not null, primary key
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  option_id  :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_options_on_option_id   (option_id)
#  index_product_options_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (option_id => options.id)
#  fk_rails_...  (product_id => products.id)
#

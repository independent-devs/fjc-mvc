# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :option_type
end

# == Schema Information
#
# Table name: options
#
#  id             :bigint           not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  option_type_id :bigint           not null
#  product_id     :bigint
#
# Indexes
#
#  index_options_on_option_type_id  (option_type_id)
#  index_options_on_product_id      (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (option_type_id => option_types.id)
#  fk_rails_...  (product_id => products.id)
#

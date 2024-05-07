# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantOptionValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: variant_option_values
#
#  id                :bigint           not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_option_id :bigint           not null
#  variant_id        :bigint           not null
#
# Indexes
#
#  index_variant_option_values_on_product_option_id  (product_option_id)
#  index_variant_option_values_on_variant_id         (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_option_id => product_options.id)
#  fk_rails_...  (variant_id => variants.id)
#

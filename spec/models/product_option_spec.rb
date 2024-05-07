# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductOption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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

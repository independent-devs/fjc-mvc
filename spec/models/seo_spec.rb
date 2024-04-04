# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: seos
#
#  id               :bigint           not null, primary key
#  meta_description :string
#  meta_keywords    :string
#  meta_title       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :bigint           not null
#
# Indexes
#
#  index_seos_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#

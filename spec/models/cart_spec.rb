# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  qty        :integer          default(1), not null
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint
#  user_id    :bigint
#  variant_id :bigint           not null
#
# Indexes
#
#  index_carts_on_order_id    (order_id)
#  index_carts_on_user_id     (user_id)
#  index_carts_on_variant_id  (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#

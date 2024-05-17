# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :variant

  validates :qty, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  qty        :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  variant_id :bigint           not null
#
# Indexes
#
#  index_carts_on_user_id     (user_id)
#  index_carts_on_variant_id  (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#

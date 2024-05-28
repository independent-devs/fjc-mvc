# frozen_string_literal: true

class Cart < ApplicationRecord
  # Relations
  belongs_to :variant
  belongs_to :user, optional: true
  belongs_to :order, optional: true
  belongs_to :cart_session, optional: true

  # Scopes
  scope :not_owned, -> { where(user_id: nil) }
  scope :not_ordered, -> { where(order_id: nil) }
  scope :detailed,
        lambda {
          select('carts.*, variants.product_id, products.name AS product_name')
            .select('variants.count_on_hand, products.has_variant')
            .select('products.thumbnail_url AS product_thumbnail')
            .select('variants.thumbnail_url AS variant_thumbnail')
            .joins(:variant)
            .joins('INNER JOIN products ON products.id = variants.product_id')
        }

  # Validations
  validates :qty, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: carts
#
#  id              :bigint           not null, primary key
#  qty             :integer          default(1), not null
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cart_session_id :bigint
#  order_id        :bigint
#  user_id         :bigint
#  variant_id      :bigint           not null
#
# Indexes
#
#  index_carts_on_cart_session_id  (cart_session_id)
#  index_carts_on_order_id         (order_id)
#  index_carts_on_user_id          (user_id)
#  index_carts_on_uuid             (uuid) UNIQUE
#  index_carts_on_variant_id       (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_session_id => cart_sessions.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#

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
          select('carts.*')
            # variant_option_values
            .select("(SELECT STRING_AGG(vov.name, ', ' ORDER BY vov.position) " \
                    'FROM variant_option_values vov ' \
                    'WHERE vov.variant_id = carts.variant_id) as variant_pair')
            # variants
            .select('variants.count_on_hand, variants.is_master, variants.price as unit_price, ' \
                    'variants.product_id, variants.thumbnail_url AS variant_thumbnail')
            .joins(:variant)
            # products
            .select('products.name AS product_name, products.currency, ' \
                    'products.thumbnail_url AS product_thumbnail')
            .joins('INNER JOIN products ON products.id = variants.product_id')
          ## slow approach
          # .select('vov.variant_pair')
          # .joins("LEFT JOIN (SELECT variant_id, STRING_AGG(name, ', ' ORDER BY position) AS variant_pair " \
          #        'FROM variant_option_values GROUP BY variant_id) ' \
          #        'vov ON carts.variant_id = vov.variant_id')
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

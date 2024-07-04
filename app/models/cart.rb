# frozen_string_literal: true
# typed: true

class Cart < ApplicationRecord
  extend T::Sig

  # Relations
  belongs_to :variant
  belongs_to :user, optional: true
  belongs_to :order, optional: true
  belongs_to :guest_session, optional: true

  # Scopes
  scope :detailed,
        lambda {
          select('carts.*')
            # variant_option_values
            .select("(SELECT STRING_AGG(vov.name, ', ' ORDER BY vov.position) " \
                    'FROM variant_option_values vov ' \
                    'WHERE vov.variant_id = carts.variant_id) AS variant_pair')
            # variants
            .select('variants.count_on_hand, variants.is_master, variants.price, ' \
                    'variants.backorderable, variants.product_id, ' \
                    'variants.thumbnail_url AS variant_thumbnail')
            .joins(:variant)
            # products
            .select('products.name AS product_name, products.currency, ' \
                    'products.thumbnail_url AS product_thumbnail, ' \
                    'products.slug AS product_slug, products.uuid AS product_uuid')
            .joins('INNER JOIN products ON products.id = variants.product_id')
            .order(id: :desc)
        }

  # Validations
  validates :qty, numericality: { greater_than: 0 }
  validates :guest_session, presence: true, unless: :user
  validates :user, presence: true, unless: :guest_session

  # Generators
  after_save :create_order_item, if: :order

  private

  sig { void }
  def create_order_item
    T.must(order).order_items.create!(variant:, qty:, price: T.must(variant).price)
  end
end

# == Schema Information
#
# Table name: carts
#
#  id               :bigint           not null, primary key
#  qty              :integer          default(1), not null
#  uuid             :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :bigint
#  order_id         :bigint
#  user_id          :bigint
#  variant_id       :bigint           not null
#
# Indexes
#
#  index_carts_on_guest_session_id  (guest_session_id)
#  index_carts_on_order_id          (order_id)
#  index_carts_on_user_id           (user_id)
#  index_carts_on_uuid              (uuid) UNIQUE
#  index_carts_on_variant_id        (variant_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#

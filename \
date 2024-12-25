# frozen_string_literal: true
# typed: true

class Cart < ApplicationRecord
  # Relations
  belongs_to :variant
  belongs_to :user, optional: true
  belongs_to :guest_session, optional: true

  # Scopes
  scope :detailed,
        lambda {
          select('carts.*')
            # variant_option_values
            .select("(SELECT STRING_AGG(vov.name, ', ' ORDER BY po.position) " \
                    'FROM variant_option_values vov ' \
                    'INNER JOIN product_options AS po ON po.id = vov.product_option_id ' \
                    'WHERE carts.variant_id = vov.variant_id) AS variant_pair')
            # variants
            .select('variants.count_on_hand, variants.is_master, variants.price, ' \
                    'variants.backorderable, variants.product_id')
            .joins(:variant)
            # products
            .select('products.name AS product_name, products.currency, ' \
                    'products.id AS product_id')
            .joins('INNER JOIN products ON products.id = variants.product_id')
            .order(id: :desc)
        }

  # Validations
  validates :qty, numericality: { greater_than: 0 }
  validates :guest_session, presence: true, unless: :user
  validates :user, presence: true, unless: :guest_session

  validate :validate_ownership

  private

  def validate_ownership
    return unless user_id.present? && guest_session_id.present?

    errors.add(:ownership, I18n.t('carts.validate.ownership_cant_be_both'))
  end
end

# == Schema Information
#
# Table name: carts
#
#  id               :uuid             not null, primary key
#  qty              :integer          default(1), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  guest_session_id :uuid
#  user_id          :uuid
#  variant_id       :uuid             not null
#
# Indexes
#
#  index_carts_on_guest_session_id                             (guest_session_id)
#  index_carts_on_user_id                                      (user_id)
#  index_carts_on_variant_id                                   (variant_id)
#  index_carts_on_variant_id_and_user_id_and_guest_session_id  (variant_id,user_id,guest_session_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (guest_session_id => guest_sessions.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (variant_id => variants.id)
#

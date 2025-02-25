# frozen_string_literal: true

class ShippingDetail < ApplicationRecord
  belongs_to :shippable, polymorphic: true

  validates :fullname, :street, :phone_no, :barangay, :city, :state, :country, presence: true
  validates :phone_no, phone: { possible: true, message: I18n.t('devise.failure.phone_no.invalid') }
end

# == Schema Information
#
# Table name: shipping_details
#
#  id               :uuid             not null, primary key
#  barangay         :string           not null
#  city             :string           not null
#  country          :string           not null
#  default          :boolean          default(FALSE), not null
#  email            :string
#  fullname         :string           not null
#  phone_no         :string           not null
#  postal_code      :string
#  save_information :boolean          default(FALSE), not null
#  shippable_type   :string           not null
#  state            :string           not null
#  street           :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shippable_id     :uuid             not null
#
# Indexes
#
#  index_shipping_details_on_shippable  (shippable_type,shippable_id)
#

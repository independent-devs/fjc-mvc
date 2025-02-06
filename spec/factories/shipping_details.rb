# frozen_string_literal: true

FactoryBot.define do
  factory :shipping_detail do
    shippable { nil }
    user { nil }
    fullname { 'MyString' }
    contact_no { 'MyString' }
    email { 'MyString' }
    house_no { 'MyString' }
    village { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    country { 'MyString' }
    postal_code { 'MyString' }
  end
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

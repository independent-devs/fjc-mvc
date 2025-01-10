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
#  id             :uuid             not null, primary key
#  city           :string           not null
#  contact_no     :string           not null
#  country        :string           not null
#  email          :string
#  fullname       :string           not null
#  house_no       :string
#  postal_code    :string
#  shippable_type :string           not null
#  state          :string           not null
#  village        :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  shippable_id   :uuid             not null
#  user_id        :uuid
#
# Indexes
#
#  index_shipping_details_on_shippable  (shippable_type,shippable_id)
#  index_shipping_details_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

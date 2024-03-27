# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_no { '+639012345678' }
    name { 'John Doe' }
    admin { false }
    provider { 'phone_no' }
    password { Faker::Internet.password }
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  phone_no               :string
#  provider               :string           default("phone_no")
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_phone_no              (phone_no) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

# frozen_string_literal: true

FactoryBot.define do
  factory :payment_method do
    name { 'MyString' }
    code { 'MyString' }
  end
end

# == Schema Information
#
# Table name: payment_methods
#
#  id          :uuid             not null, primary key
#  code        :string           not null
#  credentials :json
#  enable      :boolean          default(FALSE), not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payment_methods_on_code  (code) UNIQUE
#  index_payment_methods_on_name  (name)
#

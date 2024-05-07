# frozen_string_literal: true

FactoryBot.define do
  factory :option do
    name { Faker::Types.rb_string }
  end
end

# == Schema Information
#
# Table name: options
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

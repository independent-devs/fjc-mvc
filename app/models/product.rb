# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  available_on     :datetime
#  deleted_at       :datetime
#  description      :text
#  meta_description :text
#  meta_keywords    :string
#  meta_title       :string
#  name             :string           not null
#  promotionable    :boolean          default(FALSE), not null
#  slug             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Product < ApplicationRecord
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'User using mobile number without email' do
    user = create(:user, email: nil)

    expect(user.email).to eq(nil)
    expect(user.uid).to be_blank
    expect(user.provider).to eq('phone_no')
  end

  it 'User using google auth without mobile number' do
    oauth = Faker::Omniauth.google
    user = create(:user, phone_no: nil, email: oauth[:info][:email], uid: oauth[:uid],
                         provider: oauth[:provider])

    expect(user.email).to eq(oauth[:info][:email])
    expect(user.phone_no).to eq(nil)
    expect(user.uid).to be_present
    expect(user.provider).to eq('google_oauth2')
  end

  it 'User using facebook auth without mobile number' do
    oauth = Faker::Omniauth.facebook
    user = create(:user, phone_no: nil, email: oauth[:info][:email], uid: oauth[:uid],
                         provider: oauth[:provider])

    expect(user.email).to eq(oauth[:info][:email])
    expect(user.phone_no).to eq(nil)
    expect(user.uid).to be_present
    expect(user.provider).to eq('facebook')
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

# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable, :omniauthable,
         omniauth_providers: %i[facebook google_oauth2],
         authentication_keys: %i[phone_no]

  ALLOWED_PROVIDER = %w[phone_no google_oauth2 facebook].freeze

  validates :provider, inclusion: { in: ALLOWED_PROVIDER }
  validates :email, uniqueness: { allow_nil: true }
  validates :phone_no, uniqueness: { allow_nil: true }
  validates :phone_no, presence: true, if: -> { provider == 'phone_no' }
  validates :phone_no, phone: { possible: true, message: I18n.t('devise.failure.phone_no.invalid') },
                       if: -> { phone_no.present? }

  def remember_me
    super.nil? ? true : super
  end

  def email_required?
    provider != 'phone_no'
  end

  def email_changed?
    true
  end

  def self.find_for_authentication(conditions = {})
    return nil if conditions[:phone_no].blank?

    find_by(phone_no: conditions[:phone_no])
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.name = provider_data.info.name
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
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

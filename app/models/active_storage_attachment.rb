# frozen_string_literal: true

class ActiveStorageAttachment < ApplicationRecord
  belongs_to :record_owner, polymorphic: true, optional: true
end

# == Schema Information
#
# Table name: active_storage_attachments
#
#  id                :bigint           not null, primary key
#  deleted_at        :datetime
#  name              :string           not null
#  position          :integer
#  record_owner_type :string
#  record_type       :string           not null
#  created_at        :datetime         not null
#  blob_id           :bigint           not null
#  record_id         :bigint           not null
#  record_owner_id   :bigint
#
# Indexes
#
#  index_active_storage_attachments_on_blob_id     (blob_id)
#  index_active_storage_attachments_on_deleted_at  (deleted_at)
#  index_active_storage_attachments_on_position    (position)
#  index_active_storage_attachments_record_owner   (record_owner_type,record_owner_id)
#  index_active_storage_attachments_uniqueness     (record_type,record_id,name,blob_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (blob_id => active_storage_blobs.id)
#

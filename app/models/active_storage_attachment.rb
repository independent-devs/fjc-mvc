# frozen_string_literal: true

class ActiveStorageAttachment < ApplicationRecord
  include RankedModel

  ranks :sort_order, column: :position, with_same: %i[record_id record_type name]
end

# == Schema Information
#
# Table name: active_storage_attachments
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  position          :integer          default(0)
#  record_owner      :string
#  record_owner_type :string
#  record_type       :string           not null
#  created_at        :datetime         not null
#  blob_id           :bigint           not null
#  record_id         :bigint           not null
#  record_owner_id   :bigint
#
# Indexes
#
#  index_active_storage_attachments_on_blob_id    (blob_id)
#  index_active_storage_attachments_on_position   (position)
#  index_active_storage_attachments_record_owner  (record_owner,record_owner_id)
#  index_active_storage_attachments_uniqueness    (record_type,record_id,name,blob_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (blob_id => active_storage_blobs.id)
#

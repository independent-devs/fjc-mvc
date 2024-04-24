# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  included do
    include RankedModel

    belongs_to :record_owner, polymorphic: true
    ranks :sort_order, column: :position, with_same: %i[record_id record_type name]
  end
end

Rails.configuration.to_prepare do
  ActiveSupport.on_load(:active_storage_attachment) { include ActiveStorageAttachmentExtension }
end

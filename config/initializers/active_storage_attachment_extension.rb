# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  # re-run the application to make this extension take effect
  included do
    include RankedModel

    # Scopes
    scope :sort_by_position, -> { rank(:sort_order) }

    # Position
    ranks :sort_order, column: :position, with_same: %i[record_id record_type name]
  end
end

Rails.configuration.to_prepare do
  ActiveSupport.on_load(:active_storage_attachment) { include ActiveStorageAttachmentExtension }
end

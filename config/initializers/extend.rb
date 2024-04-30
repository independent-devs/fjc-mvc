# frozen_string_literal: true

module ActiveStorageAttachmentExtension
  extend ActiveSupport::Concern

  # re-run the application to make this extension take effect
  included do
    include RankedModel

    # Relations
    belongs_to :record_owner, polymorphic: true, optional: true

    # Scopes
    scope :sort_by_position, -> { rank(:sort_order) }
    scope :not_deleted, -> { where(deleted_at: nil) }

    # Position
    ranks :sort_order, column: :position, with_same: %i[record_id record_type name], scope: :not_deleted

    # Generators
    before_save :record_owner_blank, if: :record_owner_blank_condition

    private

    # For generators
    def record_owner_blank_condition
      record_owner_id.blank? || record_owner_type.blank?
    end

    def record_owner_blank
      self.record_owner_id = nil
      self.record_owner_type = nil
    end
  end
end

Rails.configuration.to_prepare do
  ActiveSupport.on_load(:active_storage_attachment) { include ActiveStorageAttachmentExtension }
end

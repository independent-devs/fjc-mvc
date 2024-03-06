# frozen_string_literal: true

class SidebarLinkComponent < ViewComponent::Base
  attr_reader :path, :sub_paths, :label, :icon

  def initialize(label:, path: '/', sub_paths: [], icon: nil)
    @label = label
    @path = path
    @sub_paths = sub_paths
    @icon = icon
    super
  end
end

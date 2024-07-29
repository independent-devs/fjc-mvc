# frozen_string_literal: true

class SidebarLinkComponent < ViewComponent::Base
  attr_reader :path, :sub_paths, :label, :sn_icon

  def initialize(label:, path: '/', sub_paths: [], icon: nil)
    @label = label
    @path = path
    @sub_paths = sub_paths
    @sn_icon = icon
    super
  end
end

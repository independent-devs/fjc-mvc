# frozen_string_literal: true

class SidebarLinkComponent < ViewComponent::Base
  attr_reader :path, :sub_paths, :label

  def initialize(label:, path: '/', sub_paths: [])
    @label = label
    @path = path
    @sub_paths = sub_paths
    super
  end
end

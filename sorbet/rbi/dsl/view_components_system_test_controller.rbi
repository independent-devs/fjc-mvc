# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ViewComponentsSystemTestController`.
# Please instead update this file by running `bin/tapioca dsl ViewComponentsSystemTestController`.


class ViewComponentsSystemTestController
  include GeneratedUrlHelpersModule
  include GeneratedPathHelpersModule

  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::Turbo::DriveHelper
    include ::Turbo::FramesHelper
    include ::Turbo::IncludesHelper
    include ::Turbo::StreamsHelper
    include ::ActionView::Helpers::CaptureHelper
    include ::ActionView::Helpers::OutputSafetyHelper
    include ::ActionView::Helpers::TagHelper
    include ::Turbo::Streams::ActionHelper
    include ::ActionText::ContentHelper
    include ::ActionText::TagHelper
    include ::Importmap::ImportmapTagsHelper
    include ::ActionController::Base::HelperMethods
    include ::AccountHelper
    include ::Pagy::UrlHelpers
    include ::Pagy::Frontend
    include ::ApplicationHelper
    include ::CartsHelper
    include ::CategoriesHelper
    include ::HomeHelper
    include ::ImagesHelper
    include ::OptionsHelper
    include ::OrdersHelper
    include ::ProductsHelper
    include ::StocksHelper
    include ::UsersHelper
    include ::VariantsHelper
    include ::PreviewHelper
    include ::DeviseHelper
  end

  class HelperProxy < ::ActionView::Base
    include HelperMethods
  end
end

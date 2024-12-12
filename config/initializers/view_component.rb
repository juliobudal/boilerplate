# Configure ViewComponent
Rails.application.config.view_component.preview_paths << Rails.root.join("spec/components/previews")
Rails.application.config.view_component.preview_route = "/previews"
Rails.application.config.view_component.preview_controller = "PreviewController"
Rails.application.config.view_component.component_parent_class = "ViewComponent::Base"

# Configure Lookbook
if defined?(Lookbook)
  Lookbook.configure do |config|
    config.preview_layout = "preview"
  end
end

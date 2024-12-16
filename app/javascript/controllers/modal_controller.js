import { Controller } from "@hotwired/stimulus"
import "flowbite"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["flowbiteModal"]

  connect() {
    // Initialize Flowbite modal using the flowbite target
    this.modal = new Modal(this.flowbiteModalTarget, {
      backdrop: 'dynamic',
      backdropClasses: 'bg-gray-900/50 dark:bg-gray-900/80 fixed inset-0 z-40'
    })
  }

  open(event) {
    if (event) {
      event.preventDefault()
    }
    this.modal.show()
  }

  close() {
    this.modal.hide()
  }

  // Handle successful form submission
  success(event) {
    const response = event.detail.fetchResponse
    if (response.succeeded) {
      this.close()
      // Refresh the page to show updated content
      Turbo.visit(window.location.href, { action: "replace" })
    }
  }
}

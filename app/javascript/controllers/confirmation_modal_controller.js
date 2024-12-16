import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirmation-modal"
export default class extends Controller {
  static targets = ["modal"]
  
  connect() {
    // Add event listener for the cancel button
    const cancelButton = this.modalTarget.querySelector('[data-action="confirmation-modal#hide"]')
    if (cancelButton) {
      cancelButton.addEventListener('click', () => this.hide())
    }
  }

  show(event) {
    event.preventDefault()
    const button = event.currentTarget
    const form = button.closest('form')
    
    // Clone the form and add it to the modal
    const clonedForm = form.cloneNode(true)
    clonedForm.classList.add('inline-block')
    
    // Remove the trash icon from the cloned form
    const trashIcon = clonedForm.querySelector('svg')
    if (trashIcon) {
      trashIcon.remove()
    }
    
    const submitButton = document.createElement('button')
    submitButton.setAttribute('type', 'submit')
    submitButton.setAttribute('form', clonedForm.id)
    submitButton.classList.add(
      'text-white', 'bg-red-600', 'hover:bg-red-800',
      'focus:ring-4', 'focus:outline-none', 'focus:ring-red-300',
      'font-medium', 'rounded-lg', 'text-sm', 'inline-flex',
      'items-center', 'px-5', 'py-2.5', 'text-center'
    )
    submitButton.textContent = 'Delete'
    
    const confirmationModalAction = document.getElementById('confirmationModalAction')
    confirmationModalAction.innerHTML = ''
    confirmationModalAction.appendChild(clonedForm)
    clonedForm.appendChild(submitButton)
    
    this.modalTarget.classList.remove('hidden')
    this.modalTarget.classList.add('flex')
  }

  hide() {
    this.modalTarget.classList.add('hidden')
    this.modalTarget.classList.remove('flex')
  }
}

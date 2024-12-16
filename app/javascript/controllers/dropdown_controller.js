import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this.addClickOutsideListener()
  }

  disconnect() {
    this.removeClickOutsideListener()
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  hide(event) {
    if (this.element.contains(event.target)) return
    this.menuTarget.classList.add("hidden")
  }

  addClickOutsideListener() {
    document.addEventListener("click", this.hide.bind(this))
  }

  removeClickOutsideListener() {
    document.removeEventListener("click", this.hide.bind(this))
  }
}

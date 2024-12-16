import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]

  connect() {
    this.showTab(0)
  }

  switch(event) {
    event.preventDefault()
    const button = event.currentTarget
    const index = this.tabTargets.indexOf(button)
    this.showTab(index)
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      const panel = this.panelTargets[i]
      if (i === index) {
        tab.setAttribute('aria-selected', 'true')
        tab.classList.remove('text-gray-500', 'hover:text-gray-700', 'border-transparent')
        tab.classList.add('text-indigo-600', 'border-indigo-600')
        panel.classList.remove('hidden')
      } else {
        tab.setAttribute('aria-selected', 'false')
        tab.classList.add('text-gray-500', 'hover:text-gray-700', 'border-transparent')
        tab.classList.remove('text-indigo-600', 'border-indigo-600')
        panel.classList.add('hidden')
      }
    })
  }
}

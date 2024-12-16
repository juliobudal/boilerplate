import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["column"]

  connect() {
    this.columnTargets.forEach(column => {
      new Sortable(column.querySelector("ul"), {
        group: "goals",
        animation: 150,
        ghostClass: "opacity-50",
        onEnd: async (event) => {
          const goalId = event.item.dataset.goalId
          const studyAreaId = event.item.dataset.studyAreaId
          const newStatus = event.to.closest("[data-status]").dataset.status
          const oldStatus = event.from.closest("[data-status]").dataset.status

          if (newStatus === oldStatus) return

          try {
            const response = await fetch(`/study_areas/${studyAreaId}/goals/${goalId}/update_status`, {
              method: "PATCH",
              headers: {
                "Content-Type": "application/json",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
              },
              body: JSON.stringify({ status: newStatus })
            })

            if (response.ok) {
              // Update the counts
              const oldCounter = document.querySelector(`[data-status="${oldStatus}"] [data-count]`)
              const newCounter = document.querySelector(`[data-status="${newStatus}"] [data-count]`)

              if (oldCounter) oldCounter.textContent = parseInt(oldCounter.textContent) - 1
              if (newCounter) newCounter.textContent = parseInt(newCounter.textContent) + 1

              // Update the card's status
              event.item.dataset.currentStatus = newStatus

              // Update the status badge color if it exists
              const statusBadge = event.item.querySelector("[data-status-badge]")
              if (statusBadge) {
                const oldColorClass = statusBadge.className.match(/bg-\w+-50/)[0]
                const newColorClass = `bg-${this.getStatusColor(newStatus)}-50`
                statusBadge.className = statusBadge.className.replace(oldColorClass, newColorClass)
              }

              // Handle empty states
              this.updateEmptyStates(event.from, event.to)
            } else {
              // If the update failed, move the item back
              event.from.appendChild(event.item)
            }
          } catch (error) {
            console.error("Error updating goal status:", error)
            // If there was an error, move the item back
            event.from.appendChild(event.item)
          }
        }
      })
    })
  }

  updateEmptyStates(fromList, toList) {
    // Handle the source list (where the card was dragged from)
    if (fromList.querySelectorAll("[data-drag-target='card']").length === 0) {
      const emptyState = this.createEmptyState()
      fromList.appendChild(emptyState)
    }

    // Handle the target list (where the card was dragged to)
    const toListEmptyState = toList.querySelector(".empty-state")
    if (toListEmptyState) {
      toListEmptyState.remove()
    }
  }

  createEmptyState() {
    const li = document.createElement("li")
    li.className = "relative flex items-center space-x-3 rounded-lg border border-dashed border-gray-100 shadow-sm px-6 py-5 empty-state"
    
    const div = document.createElement("div")
    div.className = "min-w-0 flex-1"
    
    const p = document.createElement("p")
    p.className = "text-sm text-gray-500 text-center"
    // Get the translated message from any existing empty message
    const textContent = document.querySelector("[data-empty-message]")?.textContent 
    li.dataset.emptyMessage = textContent
    const message = textContent || "No goals in this status"
    p.textContent = message
    
    div.appendChild(p)
    li.appendChild(div)
    
    return li
  }

  getStatusColor(status) {
    const colors = {
      not_started: "gray",
      in_progress: "yellow",
      completed: "green",
      blocked: "red"
    }
    return colors[status] || "gray"
  }
}

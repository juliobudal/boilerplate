import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "startButton", "pauseButton", "resetButton"]
  static values = {
    duration: Number,
    goalId: Number
  }

  connect() {
    this.timeLeft = this.durationValue * 60
    this.isRunning = false
    this.updateDisplay()
  }

  start() {
    if (!this.isRunning) {
      this.isRunning = true
      this.startTime = new Date()
      this.timer = setInterval(() => this.tick(), 1000)
      this.startButton.disabled = true
      this.pauseButton.disabled = false
      
      // Create study session
      fetch('/study_sessions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          study_session: {
            goal_id: this.goalIdValue,
            duration_minutes: this.durationValue
          }
        })
      })
    }
  }

  pause() {
    if (this.isRunning) {
      this.isRunning = false
      clearInterval(this.timer)
      this.startButton.disabled = false
      this.pauseButton.disabled = true
    }
  }

  reset() {
    this.pause()
    this.timeLeft = this.durationValue * 60
    this.updateDisplay()
    this.startButton.disabled = false
    this.resetButton.disabled = true
  }

  tick() {
    this.timeLeft -= 1
    if (this.timeLeft <= 0) {
      this.complete()
    }
    this.updateDisplay()
  }

  complete() {
    this.pause()
    this.dispatch("complete")
    new Audio('/notification.mp3').play()
    this.resetButton.disabled = false
  }

  updateDisplay() {
    const minutes = Math.floor(this.timeLeft / 60)
    const seconds = this.timeLeft % 60
    this.displayTarget.textContent = 
      `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
  }

  get startButton() {
    return this.startButtonTarget
  }

  get pauseButton() {
    return this.pauseButtonTarget
  }

  get resetButton() {
    return this.resetButtonTarget
  }
}

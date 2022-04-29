import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  // Value attributes must be placed on the controller element
  // eg. data-controller="alert" data-alert-close-after-value="500"
  static values = {
    closeAfter: {
      type: Number,
      default: 2500
    },
    removeAfter: {
      type: Number,
      default: 1100
    },
  }

  // Execute once, when page loaded (first instantiated)
  initialize() {
    this.hide()
  }

  // Execute anytime the controller is connected to the DOM
  connect() {
    setTimeout(() => {
      this.show()
    }, 50)
    setTimeout(() => {
      this.close()
    }, this.closeAfterValue)
  }

  // Actions can be on the controller element or any children of the controller.
  // data-action="alert#close"
  close() {
    this.hide()
    setTimeout(() => {
      this.element.remove()
    }, this.removeAfterValue)

  }

  show() {
    this.element.setAttribute(
      'style',
      "transition: 0.5s; transform:translate(0, -100px);",
    )
  }

  hide() {
    this.element.setAttribute(
      'style',
      "transition: 1s; transform:translate(0, 200px);",
    )
  }
}

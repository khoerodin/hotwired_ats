import { Controller } from "stimulus"
import debounce from "lodash/debounce"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    this.submit = debounce(this.submit.bind(this), 200)
  }

  submit() {
    this.formTarget.requestSubmit()
  }
}

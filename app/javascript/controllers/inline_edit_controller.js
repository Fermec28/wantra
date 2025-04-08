import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "input", "form"]

  activate() {
    this.displayTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
    this.inputTarget.focus()
  }

  submit(event) {
    this.formTarget.requestSubmit()
  }

  cancel() {
    this.formTarget.classList.add("hidden")
    this.displayTarget.classList.remove("hidden")
  }
}
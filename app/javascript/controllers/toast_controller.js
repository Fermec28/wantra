import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => this.dismiss(), 5000) // auto-dismiss after 5s
  }

  dismiss() {
    this.element.remove()
  }
}
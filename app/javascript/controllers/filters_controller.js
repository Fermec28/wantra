import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["customFields", "period"]

  connect() {
    this.toggleCustomFields()
  }

  toggleCustomFields() {
    const selectedPeriod = this.periodTarget.value
    this.customFieldsTarget.hidden = selectedPeriod !== "custom"
  }
}
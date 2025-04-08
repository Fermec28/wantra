import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["accountTo", "amountTo"]

  kindChanged(event) {
    const kind = event.target.value
    const isTransfer = kind === "transfer"

    this.accountToTarget.classList.toggle("hidden", !isTransfer)
    this.amountToTarget.classList.toggle("hidden", !isTransfer)
  }
}
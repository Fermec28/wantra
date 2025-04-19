import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "accountFrom", "accountTo",
    "amountFrom", "amountTo",
    "txnKind", "amountFromInput", "amountToInput"
  ]

  connect() {
    this.updateAmountColors()
  }

  kindChanged(event) {
    this.updateVisibility()
    this.updateAmountColors()
  }

  updateVisibility() {
    const kind = this.txnKindTarget.value
    const isTransfer = kind === "transfer"

    this.accountToTarget.classList.toggle("hidden", !isTransfer)
    this.amountToTarget.classList.toggle("hidden", !isTransfer)
  }

  updateAmountColors() {
    const kind = this.txnKindTarget.value

    // Reset classes
    this.amountFromInputTarget.className = "block w-full border rounded mt-1"
    this.amountToInputTarget.className = "block w-full border rounded mt-1"

    if (kind === "income") {
      this.amountFromInputTarget.classList.add("text-green-600")
    } else if (kind === "expense") {
      this.amountFromInputTarget.classList.add("text-red-500")
    } else if (kind === "transfer") {
      this.amountFromInputTarget.classList.add("text-red-500")
      this.amountToInputTarget.classList.add("text-green-600")
    }
  }
}
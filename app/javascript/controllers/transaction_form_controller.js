import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["accountTo", "amountTo"]

  connect() {
    const select = this.element.querySelector('[name="transaction[account_id]"]')
    if (select) {
      this.update({ target: select })
    }

    const toSelect = this.element.querySelector('[name="transaction[to_account_id]"]')
    if (toSelect) {
      this.updateToAccount({ target: toSelect })
    }
  }

  kindChanged(event) {
    const kind = event.target.value
    const isTransfer = kind === "transfer"

    this.accountToTarget.classList.toggle("hidden", !isTransfer)
    this.amountToTarget.classList.toggle("hidden", !isTransfer)
  }

  update(event) {
    const select = event.target
    const selected = select.options[select.selectedIndex].text
    const preview = document.getElementById("account-summary")

    if (selected && preview) {
      preview.textContent = `Cuenta seleccionada: ${selected}`
      preview.classList.remove("hidden")
    }
  }

  updateToAccount(event) {
    const select = event.target
    const selected = select.options[select.selectedIndex].text
    const preview = document.getElementById("to-account-summary")
  
    if (selected && preview) {
      preview.textContent = `Cuenta destino: ${selected}`
      preview.classList.remove("hidden")
    }
  }
}
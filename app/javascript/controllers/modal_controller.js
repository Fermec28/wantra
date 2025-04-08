import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close(event) {
    event.preventDefault()
    const modal = document.getElementById("modal")
    if (modal) modal.innerHTML = ""
  }
}
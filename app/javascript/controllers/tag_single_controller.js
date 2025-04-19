// app/javascript/controllers/tag_single_controller.js
import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    new TomSelect(this.element, {
      maxItems: 1,
      create: true,
      persist: false,
      options: this.optionsFromElement(),
      labelField: "name",
      valueField: "name",
      searchField: ["name"]
    })
  }

  optionsFromElement() {
    const existingTags = JSON.parse(this.element.dataset.existingTags || "[]")
    return existingTags.map(tag => ({ name: tag }))
  }
}

import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    new TomSelect(this.element, {
      plugins: ['remove_button'],
      maxItems: null,
      create: false,
      persist: false,
      closeAfterSelect: true,
      render: {
        item: function(data, escape) {
          return `<div class="inline text-xs px-2 py-1 bg-gray-100 rounded mr-1">${escape(data.text)}</div>`;
        }
      }
    })
  }
}

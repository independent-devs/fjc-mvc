import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

// Connects to data-controller="product--with-slim"
export default class extends Controller {
  static targets = ["optionInput"]

  connect() {
    this.slim = new SlimSelect({
      select: this.optionInputTarget,
      settings: {
        hideSelected: true,
        closeOnSelect: false,
        maxSelected: 3,
      }
    })
  }

  hasVariantToogle() {
    if (this.slim.settings.disabled) {
      this.slim.enable()
      return
    }

    this.slim.disable()
    this.slim.setSelected([])
  }
}

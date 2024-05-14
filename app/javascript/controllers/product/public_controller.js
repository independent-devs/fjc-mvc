import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product--public"
export default class extends Controller {
  static targets = ["options", "addToCartBtn", "buyNowBtn"]

  radioToggle(event) {
    const radioName = event.target.name
    const radioID = event.target.id

    // clear radio not including the event element
    this.setRadios(radioName, null, radioID)

    if (event.target.dataset.wasChecked == "true") {
      // set radio with the event element
      this.setRadios(radioName, radioID, null)
      return
    }

    event.target.checked = true
    event.target.dataset.wasChecked = true
  }

  setRadios(name, includeId, excludeId) {
    let query = `input[type="radio"][name="${name}"]`

    if (includeId) query += `[id="${includeId}"]`
    if (excludeId) query += `:not([id="${excludeId}"]`

    this.optionsTarget.querySelectorAll(query).forEach((element) => {
      element.checked = false
      element.dataset.wasChecked = false
    })
  }
}

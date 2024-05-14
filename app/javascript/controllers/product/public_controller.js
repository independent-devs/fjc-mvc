import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product--public"
export default class extends Controller {
  static targets = ["options", "addToCartBtn", "buyNowBtn"]

  radioToggle(event) {
    if (event.target.dataset.wasChecked == "true") {
      event.target.checked = false
      event.target.dataset.wasChecked = false
      return
    }

    event.target.checked = true
    event.target.dataset.wasChecked = true
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product--public"
export default class extends Controller {
  static targets = ["options", "addToCartBtn", "buyNowBtn"]

  connect() { }
}

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart--item"
export default class extends Controller {
  static targets = ["quantity"];

  /* Quantity */
  increment() {
    if (this.quantityTarget.disabled) return;
    this.quantityTarget.stepUp();
    this.updateQuantity(this.quantityTarget.value);
  }

  decrement() {
    if (this.quantityTarget.disabled) return;
    this.quantityTarget.stepDown();
    this.updateQuantity();
  }

  updateQuantity() {
    clearTimeout(this.timeout);

    this.timeout = setTimeout(() => {
      this.quantityTarget.disabled = true;
    }, 1000);
  }
}

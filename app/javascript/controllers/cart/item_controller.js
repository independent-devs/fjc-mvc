import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart--item"
export default class extends Controller {
  static targets = ["quantity"];

  /* Quantity */
  increment() {
    if (this.quantityTarget.disabled) return;
    this.quantityTarget.stepUp();
    this.updateQuantity();
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
      this.updateItem();
    }, 1000);
  }

  updateItem() {
    const formData = new FormData();
    formData.append("cart[qty]", this.quantityTarget.value);

    fetch(this.element.dataset.url, {
      method: "PUT",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => {
        Turbo.renderStreamMessage(html);
        this.quantityTarget.disabled = false;
      });
  }
}

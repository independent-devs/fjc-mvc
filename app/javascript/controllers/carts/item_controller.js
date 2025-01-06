import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="carts--item"
export default class extends Controller {
  static targets = ["quantity", "url", "checkbox"];

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

  sync() {
    if (!this.urlTarget.dataset.syncUrl) return;

    fetch(this.urlTarget.dataset.syncUrl, {
      method: "POST",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }

  quantityInput(event) {
    if (Number(event.target.value) < 0) event.target.value = Math.abs(event.target.value);
    else if ((event.target.value != "" || event.data == "e") && Number(event.target.value) == 0)
      event.target.value = this.quantityTarget.min;
  }

  quantityChange(event) {
    event.target.value = event.target.value || this.quantityTarget.min;
    event.target.blur();
    this.updateQuantity(0);
  }

  updateQuantity(delay = 800) {
    clearTimeout(this.timeout);

    this.timeout = setTimeout(() => {
      this.quantityTarget.disabled = true;
      this.updateItem();
    }, delay);
  }

  updateItem() {
    const formData = new FormData();
    formData.append("cart[qty]", this.quantityTarget.value);
    formData.append("checked", this.checkboxTarget.checked);

    fetch(this.urlTarget.dataset.updateUrl, {
      method: "PUT",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => {
        this.quantityTarget.disabled = false;
        return res.text();
      })
      .then((html) => Turbo.renderStreamMessage(html));
  }
}

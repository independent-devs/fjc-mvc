import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modify-stock"
export default class extends Controller {
  static targets = ["input", "action"];

  modify() {
    let formData = new FormData();
    formData.append('product_variant[modify_amount]', this.inputTarget.value);

    fetch(this.element.dataset.url, {
      method: "put",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }

  cancel() {
    this.inputTarget.value = null;
    this.actionTarget.classList.add("hidden");
  }

  change(event) {
    if (!Number(event.target.value)) {
      this.actionTarget.classList.add("hidden");
      return;
    }

    this.actionTarget.classList.remove("hidden");
  }
}

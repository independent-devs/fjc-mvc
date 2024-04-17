import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modify-stock"
export default class extends Controller {
  static targets = ["input", "action"];

  connect() {
    console.log("stockId:", this.element.dataset.stockId)
    console.log(this.inputTarget, this.actionTarget)
  }

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
    this.actionTarget
  }
}

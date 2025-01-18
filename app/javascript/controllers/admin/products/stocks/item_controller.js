import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="admin--products--stocks--item"
export default class extends Controller {
  static targets = ["input", "action"];

  modify() {
    const formData = new FormData();
    formData.append("variant[modify_amount]", this.inputTarget.value);

    fetch(this.element.dataset.modifyUrl, {
      method: "PUT",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => {
        this.inputTarget.value = null;
        this.cancel();

        return Turbo.renderStreamMessage(html);
      });
  }

  cancel() {
    this.inputTarget.value = null;
    this.actionTarget.classList.add("hidden");
  }

  change(event) {
    if (!Number(event.target.value)) this.actionTarget.classList.add("hidden");
    else this.actionTarget.classList.remove("hidden");
  }
}

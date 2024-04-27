import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image"
export default class extends Controller {
  connect() {
  }

  delete() {
    const isConfirmed = confirm("Are you sure you want to delete image?");

    if (!isConfirmed) return;

    fetch(this.element.dataset.url, {
      method: "delete",
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

}

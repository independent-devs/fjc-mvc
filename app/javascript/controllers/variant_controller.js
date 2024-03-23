import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="variant"
export default class extends Controller {
  delete() {
    fetch(this.element.dataset.url, {
      method: this.element.dataset.method,
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

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image"
export default class extends Controller {
  static targets = ["files", "image"];

  delete() {
    const isConfirmed = confirm("Are you sure you want to delete image?");

    if (!isConfirmed) return;

    fetch(this.element.dataset.url, {
      method: "DELETE",
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

  thumbnail(event) {
    const imageElement = this.imageTarget;
    const reader = new FileReader();

    reader.onload = function () {
      imageElement.src = reader.result;
    };

    reader.readAsDataURL(event.target.files[0]);
  }
}

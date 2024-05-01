import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image"
export default class extends Controller {
  static targets = ["files"]

  displayImages() {
    const images = this.filesTarget.files;

    if (!images.length) return;

    for (let i = 0; i < images.length; i++) {
      var reader = new FileReader();
      reader.onload = this.loadImage;
      reader.readAsDataURL(images[i]);
    }
  }

  loadImage(e) {
    console.log(e.target.result)
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

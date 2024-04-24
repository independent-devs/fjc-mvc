import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-image"
export default class extends Controller {
  static targets = ["files"];

  connect() {
  }

  upload(event) {
    var formData = new FormData(this.element)
    console.log(formData)
  }
}

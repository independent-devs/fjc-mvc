import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product--images--upload"
export default class extends Controller {
  static targets = ["upload", "signedImage"];

  connect() {
    this.uploadTarget.disabled = false;
  }
}

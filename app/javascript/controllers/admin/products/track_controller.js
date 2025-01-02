import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="admin--products--track"
export default class extends Controller {
  static targets = ["backorderable"];

  trackableToggle() {
    if (this.backorderableTarget.classList.contains("hidden"))
      this.backorderableTarget.classList.remove("hidden");
    else this.backorderableTarget.classList.add("hidden");
  }
}

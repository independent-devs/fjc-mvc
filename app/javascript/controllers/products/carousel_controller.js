import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product--carousel"
export default class extends Controller {
  static targets = ["main", "thumb"];

  thumbSelect() {}

  nextImg() {}

  prevImg() {}

  nextItem() {}

  prevItem() {}
}

import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product--carousel"
export default class extends Controller {
  static targets = ["main", "thumb", "items"];

  thumbSelect(event) {
    this.displayMain(event.target.dataset.position);
  }

  nextImg() {
    if (this.currentThumbPos === this.totalItems) return;
    const newPos = (this.currentThumbPos + 1).toString();
    this.displayMain(newPos);
    this.thumbSeleted(newPos);
  }

  prevImg() {
    if (this.currentThumbPos === 1) return;
    const newPos = (this.currentThumbPos - 1).toString();
    this.displayMain(newPos);
    this.thumbSeleted(newPos);
  }

  // nextItem(event) {}
  //
  // prevItem(event) {}

  displayMain(position) {
    for (let el of this.mainTargets) {
      if (el.dataset.position === position) el.classList.remove("hidden");
      else el.classList.add("hidden");
    }
  }

  thumbSeleted(newPosition) {
    for (let el of this.thumbTargets) {
      if (el.dataset.position === newPosition) el.checked = true;
      else el.checked = false;
    }
  }

  get currentThumbPos() {
    return this.strToNumber(
      this.thumbTargets.find((el) => el.checked).dataset.position
    );
  }

  strToNumber(strNum) {
    return Number(strNum);
  }

  get totalItems() {
    return this.strToNumber(this.itemsTarget.dataset.totalItems);
  }
}

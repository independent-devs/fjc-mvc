import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="products--carousel"
export default class extends Controller {
  static targets = ["main", "thumb", "items", "next", "prev"];

  thumbSelect(event) {
    this.displayMain(event.target.dataset.position);
  }

  hoverInItem(event) {
    this.displayMain(event.target.dataset.position);
  }

  hoverOutItem() {
    this.displayMain(this.currentThumbPos);
  }

  nextItem() {
    if (this.rightMostItem >= this.totalItems || this.rightMostItem == this.totalItems) return;
    this.itemsTarget.dataset.leftMost = this.leftMostItem + 1;
    this.itemsTarget.dataset.rightMost = this.rightMostItem + 1;
    this.displayThumbs();
  }

  prevItem() {
    if (this.leftMostItem <= 1) return;
    this.itemsTarget.dataset.leftMost = this.leftMostItem - 1;
    this.itemsTarget.dataset.rightMost = this.rightMostItem - 1;
    this.displayThumbs();
  }

  displayThumbs() {
    for (let el of this.thumbTargets) {
      const position = this.strToNumber(el.dataset.position);
      if (position >= this.leftMostItem && position <= this.rightMostItem) el.parentElement.classList.remove("hidden");
      else el.parentElement.classList.add("hidden");
    }

    if (this.rightMostItem == this.totalItems) this.nextTarget.disabled = true;
    else this.nextTarget.disabled = false;

    if (this.leftMostItem <= 1) this.prevTarget.disabled = true;
    else this.prevTarget.disabled = false;
  }

  displayMain(position) {
    for (let el of this.mainTargets) {
      if (el.dataset.position === position) el.classList.remove("hidden");
      else el.classList.add("hidden");
    }
  }

  get currentThumbPos() {
    return this.thumbTargets.find((el) => el.checked).dataset.position;
  }

  strToNumber(strNum) {
    return Number(strNum);
  }

  get totalItems() {
    return this.strToNumber(this.itemsTarget.dataset.totalItems);
  }

  get maxItems() {
    return this.strToNumber(this.itemsTarget.dataset.max);
  }

  get leftMostItem() {
    return this.strToNumber(this.itemsTarget.dataset.leftMost);
  }

  get rightMostItem() {
    return this.strToNumber(this.itemsTarget.dataset.rightMost);
  }
}

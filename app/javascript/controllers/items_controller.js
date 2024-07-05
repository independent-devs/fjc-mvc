import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="items"
export default class extends Controller {
  connect() {
    // Detect if element is changing
    this.observer = new MutationObserver(this.observe.bind(this));
    this.observer.observe(this.element, { childList: true, subtree: true });
  }

  observe() {
    const emptyTarget = document.getElementById(this.element.dataset.empty);

    if (this.itemCount > 0) {
      emptyTarget.classList.add("hidden");
      return;
    }

    emptyTarget.classList.remove("hidden");
  }

  get itemCount() {
    const items = document.getElementsByClassName(this.element.dataset.item);
    return items.length;
  }

  disconnect() {
    this.observer.disconnect();
  }
}

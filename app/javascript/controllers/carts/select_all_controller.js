import CheckboxSelectAll from "@stimulus-components/checkbox-select-all";

// Connects to data-controller="carts--select-all"
export default class extends CheckboxSelectAll {
  static targets = ["selected"];

  refresh() {
    super.refresh();
    this.displaySelected();
  }

  toggle(e) {
    super.toggle(e);
    this.displaySelected();
  }

  displaySelected() {
    this.selectedTarget.innerHTML = `${this.checked.length} ${this.checked.length > 1 ? "items" : "item"}`;

    if (!this.checked.length) return;

    clearTimeout(this.timeout);

    this.timeout = setTimeout(() => {
      // fetch logic here
    }, 1000);
  }
}

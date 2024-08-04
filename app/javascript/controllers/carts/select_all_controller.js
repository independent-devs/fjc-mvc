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
    clearTimeout(this.timeout);

    if (this.checked.length) {
      this.timeout = setTimeout(() => {
        // fetch logic here
      }, 1000);

      return;
    }

    this.selectedTarget.innerHTML = `${this.checked.length} Item`;
  }
}

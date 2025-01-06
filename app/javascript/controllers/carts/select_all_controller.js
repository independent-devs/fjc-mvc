import CheckboxSelectAll from "@stimulus-components/checkbox-select-all";

// Connects to data-controller="carts--select-all"
export default class extends CheckboxSelectAll {
  static targets = ["selected", "total", "bulkDeleteBtn", "selectAll", "activeCount"];

  connect() {
    this.initTotalEl = this.totalTarget.innerHTML;
  }

  refresh() {
    super.refresh();
    this.selectAllRefresh();
    this.displaySelected();
  }

  toggle(event) {
    super.toggle(event);
    this.selectAllRefresh();
    this.displaySelected();
  }

  displaySelected() {
    this.selectedTarget.innerHTML = `Total (${this.checked.length} ${this.checked.length > 1 ? "items" : "item"}):`;

    if (!this.checked.length) {
      this.totalTarget.innerHTML = this.initTotalEl || this.totalTarget.innerHTML;
      this.selectAllTarget.checked = false;
      return;
    }

    fetch(this.element.dataset.totalUrl + "?" + this.checked.map((el) => `ids[]=` + el.dataset.cartId).join("&"), {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => {
        if (!this.checked.length) return;
        return Turbo.renderStreamMessage(html);
      });
  }

  bulkDelete() {
    if (!this.checked.length) return;

    fetch(this.element.dataset.bulkDeleteUrl + "?" + this.checked.map((el) => `ids[]=` + el.dataset.cartId).join("&"), {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }

  selectAllRefresh() {
    this.activeCountTarget.innerHTML = `Select All (${this.activeCheckbox.length})`;
    this.selectAllTarget.checked = this.activeCheckbox.length == this.checked.length;
  }

  selectAllToggle(event) {
    this.toggle(event);
    super.refresh();
  }
}

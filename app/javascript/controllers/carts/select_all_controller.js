import CheckboxSelectAll from "@stimulus-components/checkbox-select-all";

// Connects to data-controller="carts--select-all"
export default class extends CheckboxSelectAll {
  static targets = ["selected", "total", "bulkDeleteBtn", "selectAll", "activeCount", "checkoutBtn"];

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
    clearTimeout(this.timeout);
    this.selectedTarget.innerHTML = `Total (${this.checked.length} ${this.checked.length > 1 ? "items" : "item"}):`;

    if (!this.checked.length) {
      this.totalTarget.innerHTML = this.initTotalEl || this.totalTarget.innerHTML;
      this.selectAllTarget.checked = false;
      return;
    }

    this.timeout = setTimeout(() => {
      fetch(this.element.dataset.totalUrl + "?" + this.cartIDSParam, {
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
    });
  }

  bulkDelete() {
    if (!this.checked.length || !confirm("Are you sure to delete selected items?")) return;

    fetch(this.element.dataset.bulkDeleteUrl + "?" + this.cartIDSParam, {
      method: "DELETE",
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
    this.bulkDeleteBtnTarget.disabled = !this.checked.length;
  }

  selectAllToggle(event) {
    this.toggle(event);
    super.refresh();
  }

  get cartIDSParam() {
    return this.checked.map((el) => `ids[]=` + el.dataset.cartId).join("&");
  }
}

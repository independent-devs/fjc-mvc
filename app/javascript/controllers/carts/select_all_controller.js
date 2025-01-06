import CheckboxSelectAll from "@stimulus-components/checkbox-select-all";

// Connects to data-controller="carts--select-all"
export default class extends CheckboxSelectAll {
  static targets = ["selected", "total"];

  connect() {
    this.initTotalEl = this.totalTarget.innerHTML;
  }

  refresh() {
    super.refresh();
    this.displaySelected();
  }

  toggle(e) {
    super.toggle(e);
    this.displaySelected();
  }

  displaySelected() {
    this.selectedTarget.innerHTML = `Total (${this.checked.length} ${this.checked.length > 1 ? "items" : "item"}):`;

    if (!this.checked.length) {
      this.totalTarget.innerHTML = this.initTotalEl || this.totalTarget.innerHTML;
      return;
    }

    const params = "?" + this.checked.map((el) => `ids[]=` + el.dataset.cartId).join("&");

    fetch(this.element.dataset.totalUrl + params, {
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
}

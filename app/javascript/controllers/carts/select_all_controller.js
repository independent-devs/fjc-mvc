import CheckboxSelectAll from "@stimulus-components/checkbox-select-all";

// Connects to data-controller="carts--select-all"
export default class extends CheckboxSelectAll {
  static targets = ["selected", "total"];

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
    this.selectedTarget.innerHTML = `Total (${this.checked.length} ${this.checked.length > 1 ? "items" : "item"}):`;

    if (!this.checked.length) return;

    const params =
      "?" + this.checked.map((el) => `ids[]=` + el.dataset.cartId).join("&");

    this.timeout = setTimeout(() => {
      fetch(this.element.dataset.totalUrl + params, {
        method: "GET",
        headers: {
          Accept: "text/vnd.turbo-stream.html",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
      })
        .then((res) => res.text())
        .then((html) => Turbo.renderStreamMessage(html));
    }, 300);
  }
}

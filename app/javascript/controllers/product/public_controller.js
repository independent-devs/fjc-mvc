import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product--public"
export default class extends Controller {
  static targets = [
    "price",
    "quantity",
    "stocks",
    "option",
    "options",
    "addToCartBtn",
    "buyNowBtn",
  ];

  connect() {
    this.initPriceHTML = this.priceTarget.outerHTML;
    this.initStocksHTML = this.stocksTarget.outerHTML;
  }

  /* Quantity */
  increment() {
    this.quantityTarget.stepUp();
  }

  decrement() {
    this.quantityTarget.stepDown();
  }

  quantityChange(event) {
    if (Number(event.target.value) < 0)
      event.target.value = Math.abs(event.target.value);
    else if (
      (event.target.value != "" || event.data == "e") &&
      Number(event.target.value) == 0
    )
      event.target.value = 1;
  }

  quantityChangeAfter(event) {
    if (event.target.value == "") event.target.value = 1;
  }

  /* Radio Inputs */
  radioToggle(event) {
    const radioName = event.target.name;
    const radioID = event.target.id;

    // clear radio not including the event element
    this.setRadios(radioName, null, radioID);

    if (event.target.dataset.wasChecked == "true") {
      this.setRadios(radioName, radioID, null); // set radio with the event element
    } else {
      event.target.checked = true;
      event.target.dataset.wasChecked = true;
    }

    this.disableGroupRadios(event, event.target.dataset.wasChecked);
    this.getVariantInfo();
  }

  getVariantInfo() {
    if (this.commonVariant) {
      fetch(`/variant_info/${this.element.dataset.pid}/${this.commonVariant}`, {
        method: "GET",
        headers: {
          Accept: "text/vnd.turbo-stream.html",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
      })
        .then((res) => res.text())
        .then((html) => {
          if (this.allRadioChecked) Turbo.renderStreamMessage(html);
        });

      return;
    }

    this.resetPriceAndStocks();
  }

  resetPriceAndStocks() {
    this.priceTarget.outerHTML = this.initPriceHTML;
    this.stocksTarget.outerHTML = this.initStocksHTML;
  }

  setRadios(groupName, includeId, excludeId) {
    let query = "input[type='radio']";

    if (groupName) query += `[name="${groupName}"]`;
    if (includeId) query += `[id="${includeId}"]`;
    if (excludeId) query += `:not([id="${excludeId}"]`;

    const radios = this.optionsTarget.querySelectorAll(query);

    for (let el of radios) {
      el.checked = false;
      el.dataset.wasChecked = false;
    }
  }

  disableGroupRadios(event, wasChecked) {
    const elements = this.otherRadios(event.target.name);

    // enable all first
    for (let el of elements) el.disabled = false;

    if (wasChecked == "false") return;

    const variantIds = this.radioVariantList(event.target);

    // disable non related variant
    for (let el of elements) {
      const otherVariantIds = this.radioVariantList(el);
      const hasVariant = variantIds.some((item) =>
        otherVariantIds.includes(item)
      );

      if (!hasVariant) {
        el.disabled = true;
        el.checked = false;
        el.dataset.wasChecked = false;
      }
    }
  }

  otherRadios(name) {
    return this.optionsTarget.querySelectorAll(
      `input[type="radio"]:not([name="${name}"])`
    );
  }

  radioVariantList(elTarget) {
    return elTarget.dataset.variantIds.split(",");
  }

  get commonVariant() {
    const collection = this.radioCollections;

    if (!collection || !collection.length) return null;

    let variantId = null;
    let frequencyMap = {};

    for (let i = 0; i < collection.length; i++) {
      const element = collection[i];

      if (frequencyMap[element]) {
        if (!variantId) {
          variantId = element;
          break;
        }
      } else frequencyMap[element] = true;
    }

    return variantId;
  }

  get allRadioChecked() {
    return this.optionTargets.length == this.checkedRadioCount;
  }

  get radioCollections() {
    if (!this.allRadioChecked) return null;

    let collection = [];

    this.optionTargets.forEach((el) => {
      const checkedEl = el.querySelector("input[type='radio']:checked");

      if (checkedEl?.dataset.variantIds)
        collection = [
          ...collection,
          ...checkedEl.dataset.variantIds.split(","),
        ];
    });

    return collection;
  }

  get checkedRadioCount() {
    return this.optionsTarget.querySelectorAll("input[type='radio']:checked")
      .length;
  }
}

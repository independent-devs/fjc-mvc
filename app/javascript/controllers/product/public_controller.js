import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product--public"
export default class extends Controller {
  static targets = [
    "vid",
    "price",
    "quantity",
    "stocks",
    "radio",
    "option",
    "options",
    "userSignedIn",
    "addToCartBtn",
    "buyNowBtn",
  ];

  connect() {
    this.initRadios();
    this.initPriceHTML = this.priceTarget.outerHTML;
    this.initStocksHTML = this.stocksTarget.outerHTML;
  }

  /* Actions */
  addToCart() {
    if (!this.vidTarget.dataset.vid) return;

    const actionPath = this.userSignedInTarget.checked
      ? "add_to_cart"
      : "guest_add_to_cart";

    const fullPath = `${window.location.origin}/carts/${this.vidTarget.dataset.vid}/${actionPath}`;

    const formData = new FormData();
    formData.append("cart[qty]", this.quantityTarget.value);

    fetch(fullPath, {
      method: "POST",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => Turbo.renderStreamMessage(html));
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
      event.target.value = this.quantityTarget.min;
  }

  quantityChangeAfter(event) {
    if (event.target.value == "") event.target.value = this.quantityTarget.min;
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
    this.variantInfo();
  }

  initRadios() {
    this.radioTargets.forEach((el) => {
      el.disabled = false;
    });
  }

  variantInfo() {
    if (!this.commonVariant) {
      this.resetPriceAndStocks();
      return;
    }

    this.setActionBtn(false);
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
        this.setActionBtn(true);
      });
  }

  resetPriceAndStocks() {
    this.priceTarget.outerHTML = this.initPriceHTML;
    this.stocksTarget.outerHTML = this.initStocksHTML;
    this.quantityTarget.value = this.quantityTarget.min;
    this.vidTarget.dataset.vid = "";
    this.setActionBtn(true);
  }

  setActionBtn(enabled = true) {
    this.buyNowBtnTarget.disabled = !enabled;
    this.addToCartBtnTarget.disabled = !enabled;
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

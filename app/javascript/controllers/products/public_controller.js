import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="products--public"
export default class extends Controller {
  static targets = [
    "vid",
    "price",
    "radio",
    "errors",
    "stocks",
    "option",
    "options",
    "quantity",
    "buyNowBtn",
    "buyNowForm",
    "userSignedIn",
    "addToCartBtn",
    "optionInstance",
  ];

  connect() {
    this.initRadios();
    this.initPriceHTML = this.priceTarget.outerHTML;
    this.initStocksHTML = this.stocksTarget.outerHTML;
    this.disableActionBtn(false);
    this.setActionBtn(this.variantID);
  }

  buyNow() {
    if (this.variantID) return;
    this.setError(true, "Please select product variation first");
  }

  /* Actions */
  addToCart() {
    if (!this.variantID) {
      this.setError(true, "Please select product variation first");
      return;
    }

    fetch(`${this.baseURL}/variants/${this.variantID}/${this.addToCartPath}`, {
      method: "POST",
      body: this.cartFormData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }

  setError(adding = true, message) {
    if (adding) {
      this.errorsTarget.classList.remove("hidden");
      this.errorsTarget.innerHTML = message || "Something went wrong.";
      return;
    }

    this.errorsTarget.classList.add("hidden");
    this.errorsTarget.innerHTML = "";
  }

  /* Quantity */
  increment() {
    this.quantityTarget.stepUp();
  }

  decrement() {
    this.quantityTarget.stepDown();
  }

  quantityInput(event) {
    if (Number(event.target.value) < 0) event.target.value = Math.abs(event.target.value);
    else if ((event.target.value != "" || event.data == "e") && Number(event.target.value) == 0)
      event.target.value = this.quantityTarget.min;
  }

  quantityOnEnter(event) {
    event.preventDefault();
    event.target.blur();
  }

  quantityChange(event) {
    event.target.value = event.target.value || this.quantityTarget.min;
    event.target.blur();
  }

  /* Radio Inputs */
  radioToggle(event) {
    // clear radio not including the event element
    this.setRadios(event.target.name, null, event.target.id);

    // set radio with the event element
    switch (event.target.dataset.wasChecked) {
      case "true":
        this.setRadios(event.target.name, event.target.id, null);
        break;
      default:
        event.target.checked = true;
        event.target.dataset.wasChecked = true;
        break;
    }

    this.disableGroupRadios(event);
    this.variantInfo(event);

    if (this.allRadioChecked) this.setError(false);
  }

  initRadios() {
    this.radioTargets.forEach((el) => (el.disabled = false));
  }

  variantInfo(event) {
    if ((this.isMultiOptions && !this.commonVariant) || (!this.isMultiOptions && !event.target.checked)) {
      this.resetPriceAndStocks();
      return;
    }

    this.disableActionBtn();

    let variantID = this.isMultiOptions ? this.commonVariant : event.target.dataset.variantIds;

    this.setActionBtn(variantID);

    fetch(`${this.baseURL}/variants/${variantID}/info`, {
      method: "GET",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => {
        if (this.allRadioChecked) Turbo.renderStreamMessage(html);
        this.disableActionBtn(false);
      });
  }

  resetPriceAndStocks() {
    this.priceTarget.outerHTML = this.initPriceHTML;
    this.stocksTarget.outerHTML = this.initStocksHTML;
    this.quantityTarget.value = this.quantityTarget.min;
    this.vidTarget.dataset.vid = "";
    this.disableActionBtn(false);
    this.setActionBtn(this.variantID);
  }

  setActionBtn(variant = "") {
    this.buyNowFormTarget.action = this.buyNowPath(variant);
    this.buyNowBtnTarget.type = variant ? "submit" : "button";
  }

  disableActionBtn(disable = true) {
    this.buyNowBtnTarget.disabled = disable;
    this.addToCartBtnTarget.disabled = disable;
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

  disableGroupRadios(event) {
    const elements = this.otherRadios(event.target.name);

    if (!elements.length) return;

    // enable all first
    for (let el of elements) el.disabled = false;

    if (!event.target.checked) return;

    const variantIds = this.radioVariantList(event.target);

    // disable non related variant
    for (let el of elements) {
      const otherVariantIds = this.radioVariantList(el);
      const hasVariant = variantIds.some((item) => otherVariantIds.includes(item));

      if (!hasVariant) {
        el.disabled = true;
        el.checked = false;
        el.dataset.wasChecked = false;
      }
    }
  }

  otherRadios(name) {
    return this.optionsTarget.querySelectorAll(`input[type="radio"]:not([name="${name}"])`);
  }

  radioVariantList(elTarget) {
    return elTarget.dataset.variantIds.split(",");
  }

  get baseURL() {
    return location.origin;
  }

  get addToCartPath() {
    return this.isUserSignedIn ? "add_to_cart" : "guest_add_to_cart";
  }

  buyNowPath(variant) {
    return this.isUserSignedIn
      ? `/variants/${variant || ":uuid"}/buy_now`
      : `/variants/${variant || ":uuid"}/guest_buy_now`;
  }

  get cartFormData() {
    const formData = new FormData();
    formData.append("cart[qty]", this.quantityTarget.value);
    return formData;
  }

  get isUserSignedIn() {
    return this.userSignedInTarget.checked;
  }

  get productID() {
    return this.element.dataset.pid;
  }

  get variantID() {
    return this.vidTarget.dataset.vid;
  }

  get isMultiOptions() {
    return this.optionInstanceTargets.length > 1;
  }

  get allRadioChecked() {
    return this.optionTargets.length == this.checkedRadioCount;
  }

  get checkedRadioCount() {
    return this.optionsTarget.querySelectorAll("input[type='radio']:checked").length;
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

  get radioCollections() {
    if (!this.allRadioChecked) return null;

    let collection = [];

    this.optionTargets.forEach((el) => {
      const checkedEl = el.querySelector("input[type='radio']:checked");
      if (checkedEl?.dataset.variantIds) collection = [...collection, ...checkedEl.dataset.variantIds.split(",")];
    });

    return collection;
  }
}

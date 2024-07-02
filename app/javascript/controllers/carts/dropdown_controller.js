import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="carts--dropdown"
export default class extends Controller {
  static targets = ["option", "optionInstance", "radio", "currentVariant"];

  connect() {
    this.loadVariant();

    document
      .getElementById(`cart-${this.cartID}-variant-pair`)
      .addEventListener("click", this.loadVariant.bind(this));
  }

  loadVariant() {
    for (let el of this.radioTargets) {
      const variantIds = el.dataset.variantIds.split(",");
      const currentvariantID = this.variantID;

      if (variantIds.includes(currentvariantID)) {
        el.checked = true;
        el.dataset.wasChecked = true;
      }

      this.disableGroupRadios(el);
      this.setToBeUpdateVariant(el);
    }
  }

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

    this.disableGroupRadios(event.target);
    this.setToBeUpdateVariant(event.target);
  }

  setToBeUpdateVariant(target) {
    this.updateVariantID = this.isMultiOptions
      ? this.commonVariant
      : target.dataset.variantIds;
  }

  setRadios(groupName, includeId, excludeId) {
    let query = "input[type='radio']";

    if (groupName) query += `[name="${groupName}"]`;
    if (includeId) query += `[id="${includeId}"]`;
    if (excludeId) query += `:not([id="${excludeId}"]`;

    const radios = this.element.querySelectorAll(query);

    for (let el of radios) {
      el.checked = false;
      el.dataset.wasChecked = false;
    }
  }

  otherRadios(name) {
    return this.element.querySelectorAll(
      `input[type="radio"]:not([name="${name}"])`
    );
  }

  radioVariantList(elTarget) {
    return elTarget.dataset.variantIds.split(",");
  }

  disableGroupRadios(target) {
    const elements = this.otherRadios(target.name);

    if (!elements.length) return;

    // enable all first
    for (let el of elements) el.disabled = false;

    if (!target.checked) return;

    const variantIds = this.radioVariantList(target);

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

  get isMultiOptions() {
    return this.optionInstanceTargets.length > 1;
  }

  get variantID() {
    return this.currentVariantTarget.dataset.value;
  }

  get cartID() {
    return this.currentVariantTarget.dataset.cart;
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
}

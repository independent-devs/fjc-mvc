import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product--public"
export default class extends Controller {
  static targets = ["option", "options", "addToCartBtn", "buyNowBtn"]

  radioToggle(event) {
    const radioName = event.target.name
    const radioID = event.target.id

    // clear radio not including the event element
    this.setRadios(radioName, null, radioID)

    if (event.target.dataset.wasChecked == "true") {
      this.setRadios(radioName, radioID, null) // set radio with the event element
    } else {
      event.target.checked = true
      event.target.dataset.wasChecked = true
    }

    this.disableGroupRadios(event, event.target.dataset.wasChecked)

    // update ui for price and stock amount
    console.log(this.commonVariant)
  }

  setRadios(groupName, includeId, excludeId) {
    let query = "input[type='radio']"

    if (groupName) query += `[name="${groupName}"]`
    if (includeId) query += `[id="${includeId}"]`
    if (excludeId) query += `:not([id="${excludeId}"]`

    const radios = this.optionsTarget.querySelectorAll(query)

    for (let el of radios) {
      el.checked = false
      el.dataset.wasChecked = false
    }
  }

  disableGroupRadios(event, wasChecked) {
    const elements = this.otherRadios(event.target.name)

    // enable all first
    for (let el of elements) el.disabled = false

    if (wasChecked == "false") return

    const variantIds = event.target.dataset.variantIds.split(",");

    // disable non related variant
    for (let el of elements) {
      const otherVariantIds = el.dataset.variantIds.split(",");
      const hasVariant = variantIds.some((item) => otherVariantIds.includes(item))

      if (!hasVariant) {
        el.disabled = true
      }
    }
  }

  otherRadios(name) {
    let query = `input[type="radio"]`
    query += `:not([name="${name}"])`

    return this.optionsTarget.querySelectorAll(query)
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
          break
        }
      } else {
        frequencyMap[element] = true;
      }
    }

    return variantId;
  }

  get radioCollections() {
    if (this.optionTargets.length != this.checkedRadioCount) return null;

    let collection = [];

    this.optionTargets.forEach((el) => {
      const checkedEl = el.querySelector("input[type='radio']:checked")

      if (checkedEl?.dataset.variantIds) {
        collection = [...collection, ...checkedEl.dataset.variantIds.split(",")];
      }
    })

    return collection;
  }

  get checkedRadioCount() {
    return this.optionsTarget.querySelectorAll("input[type='radio']:checked").length;
  }
}

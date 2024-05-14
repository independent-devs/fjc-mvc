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
      // set radio with the event element
      this.setRadios(radioName, radioID, null)
    } else {
      event.target.checked = true
      event.target.dataset.wasChecked = true
    }

    // update ui for price and stock amount
    console.log(this.commonVariant)
  }

  setRadios(name, includeId, excludeId) {
    let query = `input[type="radio"][name="${name}"]`

    if (includeId) query += `[id="${includeId}"]`
    if (excludeId) query += `:not([id="${excludeId}"]`

    this.optionsTarget.querySelectorAll(query).forEach((el) => {
      el.checked = false
      el.dataset.wasChecked = false
    })
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

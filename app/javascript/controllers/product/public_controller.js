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

    if (!collection.length) return null;

    const duplicates = [];
    const frequencyMap = {};

    for (let i = 0; i < collection.length; i++) {
      const element = collection[i];

      if (frequencyMap[element]) {
        if (!duplicates.includes(element)) {
          duplicates.push(element);
          break
        }
      } else {
        frequencyMap[element] = true;
      }
    }

    return duplicates.length ? duplicates[0] : null;
  }

  get radioCollections() {
    let collection = [];

    const checkedCount = this.optionsTarget.querySelectorAll("input[type='radio']:checked").length;

    if (this.optionTargets.length != checkedCount) return collection;

    this.optionTargets.forEach((el) => {
      const checkedEl = el.querySelector("input[type='radio']:checked")

      if (checkedEl?.dataset.variantIds) {
        collection = [...collection, ...checkedEl.dataset.variantIds.split(",")];
      }
    })

    return collection;
  }
}

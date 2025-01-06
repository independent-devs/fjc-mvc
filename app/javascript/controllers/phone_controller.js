import { Controller } from "@hotwired/stimulus";
import intlTelInput from "intl-tel-input";

// Connects to data-controller="phone"
export default class extends Controller {
  static targets = ["input", "hidden"];

  connect() {
    const COUNTRY = "PH";

    this.iti = intlTelInput(this.inputTarget, {
      utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: COUNTRY,
      allowDropdown: false,
      preferredCountries: [COUNTRY],
      onlyCountries: [COUNTRY],
      customPlaceholder: (placeholder) => "e.g. " + placeholder,
    });
  }

  telHiddenInput() {
    this.hiddenTarget.value = this.iti.getNumber();
  }
}

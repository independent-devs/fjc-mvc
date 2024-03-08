import { Controller } from "@hotwired/stimulus";
import intlTelInput from "intl-tel-input";

// Connects to data-controller="phone"
export default class extends Controller {
  static targets = ["field", "hidden"];

  connect() {
    this.fieldTarget.addEventListener("change", this.inputListener);

    this.iti = intlTelInput(this.fieldTarget, {
      utilsScript:
        "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: "PH",
      allowDropdown: false,
      preferredCountries: ["PH"],
      customPlaceholder: (placeholder) => "e.g. " + placeholder,
    });
  }

  inputListener = (_event) => {
    if (!this.iti) return;
    this.hiddenTarget.value = this.iti.getNumber();
  };

  disconnect() {
    this.fieldTarget.removeEventListener("change", this.inputListener);
  }
}

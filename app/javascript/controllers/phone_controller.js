import { Controller } from "@hotwired/stimulus";
import intlTelInput from "intl-tel-input";

// Connects to data-controller="phone"
export default class extends Controller {
  static targets = ["field", "hidden"];
  connect() {
    ["change"].forEach((eventName) => {
      this.fieldTarget.addEventListener(eventName, this.inputListener);
    });

    this.iti = intlTelInput(this.fieldTarget, {
      utilsScript:
        "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: "PH",
      allowDropdown: false,
      preferredCountries: ["ph"],
      customPlaceholder: (placeholder) => {
        return "e.g. " + placeholder;
      },
      // geoIpLookup: (callback) => {
      //   fetch("https://ipapi.co/json")
      //     .then((res) => res.json())
      //     .then((data) => callback(data.country_code));
      // },
    });
  }

  inputListener = (_event) => {
    if (!this.iti) return;
    this.hiddenTarget.value = this.iti.getNumber();
  };
}

import { Controller } from "@hotwired/stimulus";
import SlimSelect from "slim-select";

// Connects to data-controller="admin--products--form"
export default class extends Controller {
  static targets = ["optionInput", "optionContainer", "categoryInput", "thumbnail"];

  connect() {
    const optionSettings = { hideSelected: true, closeOnSelect: false, maxSelected: 3 };
    new SlimSelect({ select: this.optionInputTarget, settings: optionSettings });

    const categorySettings = { hideSelected: true, closeOnSelect: false };
    new SlimSelect({ select: this.categoryInputTarget, settings: categorySettings });
  }

  hasVariantToogle() {
    if (!this.optionContainerTarget.classList.contains("hidden")) {
      this.optionContainerTarget.classList.add("hidden");
      return;
    }
    this.optionContainerTarget.classList.remove("hidden");
  }

  thumbnail(event) {
    const imageEl = this.thumbnailTarget;
    const reader = new FileReader();
    reader.onload = () => (imageEl.src = reader.result);
    reader.readAsDataURL(event.target.files[0]);
  }
}

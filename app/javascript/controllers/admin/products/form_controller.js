import { Controller } from "@hotwired/stimulus";
import SlimSelect from "slim-select";

// Connects to data-controller="admin--products--form"
export default class extends Controller {
  static targets = ["optionInput", "optionContainer", "thumbnail"];

  connect() {
    this.slim = new SlimSelect({
      select: this.optionInputTarget,
      settings: {
        hideSelected: true,
        closeOnSelect: false,
        maxSelected: 3,
      },
    });

    this.optionInputTarget.style = "opacity: 0; height: 65px;";
    this.optionInputTarget.classList.add("absolute", "top-0");
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

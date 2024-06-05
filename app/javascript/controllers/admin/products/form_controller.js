import { Controller } from "@hotwired/stimulus";
import SlimSelect from "slim-select";

// Connects to data-controller="admin--products--form"
export default class extends Controller {
  static targets = ["optionInput", "thumbnail"];

  connect() {
    this.slim = new SlimSelect({
      select: this.optionInputTarget,
      settings: {
        hideSelected: true,
        closeOnSelect: false,
        maxSelected: 3,
      },
    });
  }

  hasVariantToogle() {
    if (this.slim.settings.disabled) {
      this.slim.enable();
      return;
    }

    this.slim.disable();
    this.slim.setSelected([]);
  }

  thumbnail(event) {
    const imageEl = this.thumbnailTarget;
    const reader = new FileReader();
    reader.onload = () => (imageEl.src = reader.result);
    reader.readAsDataURL(event.target.files[0]);
  }
}

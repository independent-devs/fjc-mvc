import Autosave from "stimulus-rails-autosave";

export default class extends Autosave {
  static targets = ["input"];
  static values = { delay: { type: Number, default: 100 } };

  connect() {
    super.connect();
  }
}

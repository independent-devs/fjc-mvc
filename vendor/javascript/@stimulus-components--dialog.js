import { Controller as e } from "@hotwired/stimulus";

const t = class _Dialog extends e {
  initialize() {
    this.forceClose = this.forceClose.bind(this);
  }
  connect() {
    this.openValue && this.open(),
      document.addEventListener("turbo:before-render", this.forceClose);
  }
  disconnect() {
    document.removeEventListener("turbo:before-render", this.forceClose);
  }
  open() {
    this.dialogTarget.showModal();
  }
  close() {
    this.dialogTarget.setAttribute("closing", ""),
      Promise.all(
        this.dialogTarget.getAnimations().map((e) => e.finished)
      ).then(() => {
        this.dialogTarget.removeAttribute("closing"), this.dialogTarget.close();
      });
  }
  backdropClose(e) {
    e.target === this.dialogTarget && this.close();
  }
  forceClose() {
    this.dialogTarget.close();
  }
};
(t.targets = ["dialog"]), (t.values = { open: { type: Boolean, default: !1 } });
let o = t;
export { o as default };

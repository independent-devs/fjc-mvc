import { Controller as t } from "@hotwired/stimulus";

const e = class _Popover extends t {
  async show(t) {
    const e = t.currentTarget;
    let r = null;
    if (
      ((r = this.hasContentTarget
        ? this.contentTarget.innerHTML
        : await this.fetch()),
      !r)
    )
      return;
    const n = document.createRange().createContextualFragment(r);
    e.appendChild(n);
  }
  hide() {
    this.hasCardTarget && this.cardTarget.remove();
  }
  async fetch() {
    if (!this.remoteContent) {
      if (!this.hasUrlValue) {
        console.error(
          "[stimulus-popover] You need to pass an url to fetch the popover content."
        );
        return;
      }
      const t = await fetch(this.urlValue);
      this.remoteContent = await t.text();
    }
    return this.remoteContent;
  }
};
(e.targets = ["card", "content"]), (e.values = { url: String });
let r = e;
export { r as default };

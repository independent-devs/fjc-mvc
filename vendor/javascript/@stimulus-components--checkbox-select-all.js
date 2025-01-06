import { Controller as e } from "@hotwired/stimulus";

const t = class _CheckboxSelectAll extends e {
  initialize() {
    (this.toggle = this.toggle.bind(this)), (this.refresh = this.refresh.bind(this));
  }
  checkboxAllTargetConnected(e) {
    e.addEventListener("change", this.toggle), this.refresh();
  }
  checkboxTargetConnected(e) {
    e.addEventListener("change", this.refresh), this.refresh();
  }
  checkboxAllTargetDisconnected(e) {
    e.removeEventListener("change", this.toggle), this.refresh();
  }
  checkboxTargetDisconnected(e) {
    e.removeEventListener("change", this.refresh), this.refresh();
  }
  toggle(e) {
    e.preventDefault(),
      this.checkboxTargets.forEach((t) => {
        (t.checked = !t.disabled && e.target.checked), this.triggerInputEvent(t);
      });
  }
  refresh() {
    const e = this.activeCheckbox.length,
      t = this.checked.length;
    (this.checkboxAllTarget.checked = t > 0), (this.checkboxAllTarget.indeterminate = t > 0 && t < e);
  }
  triggerInputEvent(e) {
    const t = new Event("input", { bubbles: !1, cancelable: !0 });
    e.dispatchEvent(t);
  }
  get checked() {
    return this.checkboxTargets.filter((e) => e.checked);
  }
  get unchecked() {
    return this.checkboxTargets.filter((e) => !e.checked);
  }
  get activeCheckbox() {
    return this.checkboxTargets.filter((e) => !e.disabled);
  }
};
t.targets = ["checkboxAll", "checkbox"];
let h = t;
export { h as default };

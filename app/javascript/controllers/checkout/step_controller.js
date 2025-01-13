import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="checkout--step"
export default class extends Controller {
  static targets = [
    "shipping",
    "payment",
    "shippingStepContainer",
    "paymentStepContainer",
    "shippingStepCircle",
    "paymentStepCircle",
  ];

  backToShipping() {
    this.shippingTarget.classList.remove("hidden");
    this.shippingStepCircleTarget.classList.remove("border-gray-500");
    this.shippingStepCircleTarget.classList.add("border-primary");
    this.shippingStepContainerTarget.classList.remove("text-gray-500");
    this.shippingStepContainerTarget.classList.add("text-primary");

    this.paymentTarget.classList.add("hidden");
    this.paymentStepCircleTarget.classList.add("border-gray-500");
    this.paymenttepCircleTarget.classList.remove("border-primary");
    this.paymentStepContainerTarget.classList.add("text-gray-500");
    this.paymentStepContainerTarget.classList.remove("text-primary");
  }
}

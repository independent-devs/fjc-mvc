import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="admin--products--images--upload"
export default class extends Controller {
  static targets = [
    "upload",
    "dropArea",
    "uploading",
    "signedImage",
    "uploadingContainer",
  ];

  connect() {
    this.uploadTarget.disabled = false;

    ["dragenter", "dragover", "dragleave", "drop"].forEach((en) => {
      this.dropAreaTarget.addEventListener(en, this.handler.bind(this), false);
    });
  }

  handler(event) {
    event.preventDefault();
    event.stopPropagation();

    if (this.uploadTarget.disabled) return;

    switch (event.type) {
      case "dragenter":
      case "dragover":
        event.target.classList.add("border-primary");
        event.target.classList.add("text-primary");
        break;
      case "dragleave":
      case "drop":
        event.target.classList.remove("border-primary");
        event.target.classList.remove("text-primary");
        if (event.type != "drop") return;
        this.uploadTarget.disabled = true;
        this.displayImages(event.dataTransfer.files);
        setTimeout(this.uploadFiles.bind(this, event.dataTransfer.files), 2000);
        break;
      case "input":
        this.uploadTarget.disabled = true;
        this.displayImages(event.target.files);
        setTimeout(this.uploadFiles.bind(this, event.target.files), 2000);
        break;
      default:
        break;
    }
  }

  displayImages(files) {
    this.uploadingContainerTarget.classList.remove("hidden");
    const uploadingEl = this.uploadingTarget;

    for (let i = 0; i < files.length; i++) {
      const isFileAllowed = this.allowedFileTypes.includes(files[i].type);
      const reader = new FileReader();

      // create element
      const container = document.createElement("div");
      const fileName = document.createElement("p");
      const fileSize = document.createElement("span");

      container.classList.add("grid", "place-items-center", "w-24");
      fileSize.innerHTML = (files[i].size / (1024 * 1024)).toFixed(2) + " MB";
      fileName.innerHTML = isFileAllowed ? files[i].name : "Invalid file";
      fileSize.classList.add(
        isFileAllowed ? "text-gray-800" : "text-red-600",
        "text-sm",
        "mt-1"
      );
      fileName.classList.add(
        isFileAllowed ? "text-gray-800" : "text-red-600",
        "text-sm",
        "break-all",
        "line-clamp-2"
      );

      reader.onload = (e) => {
        const img = new Image();
        img.src = e.target.result;
        img.classList.add(
          isFileAllowed ? "border-gray-300" : "border-red-600",
          "border",
          "object-cover",
          "rounded-sm",
          "h-24",
          "w-24"
        );

        container.appendChild(img);
        container.appendChild(fileSize);
        container.appendChild(fileName);
        uploadingEl.appendChild(container);
      };

      reader.readAsDataURL(files[i]);
    }
  }

  uploadFiles(files) {
    const formData = new FormData();
    const formImageName = "product_image[images][]";

    this.signedImageTargets.forEach((el) =>
      formData.append(formImageName, el.dataset.signedId)
    );

    for (let file of files) {
      if (this.allowedFileTypes.includes(file.type))
        formData.append(formImageName, file);
    }

    fetch(this.element.dataset.uploadUrl, {
      method: "POST",
      body: formData,
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    })
      .then((res) => res.text())
      .then((html) => {
        Turbo.renderStreamMessage(html);
        this.uploadTarget.disabled = false;
      });
  }

  get allowedFileTypes() {
    return this.uploadTarget.accept.split(", ");
  }
}

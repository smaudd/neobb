import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["hidden"];

  connect() {}

  toggle(e) {
    document.querySelector(e.target.dataset.target).classList.toggle("hidden");
  }
}

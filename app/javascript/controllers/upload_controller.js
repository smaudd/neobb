import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {}

  upload(e) {
    const value = e.target.files[0];
    const reader = new FileReader();
    reader.onload = (file) => {
      const result = file.target.result;
      e.target.parentElement.querySelector("img").src = result;
      document.querySelector("#notice").innerHTML = "Remember to save your changes!";
      document.querySelector("#notice").classList.add("hidden");
      requestAnimationFrame(() => {
        document.querySelector("#notice").classList.remove("hidden");
      })
    };
    reader.readAsDataURL(value);
  }
}

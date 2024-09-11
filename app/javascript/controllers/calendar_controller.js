import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['container']
  static values = {
    events: Array
  }

  connect() {
    this.element.textContent = "Calendar Enabled"
  }
}

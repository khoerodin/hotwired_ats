import { Application } from "@hotwired/stimulus"
import StimulusReflex from "stimulus_reflex"

const application = Application.start()

// Configure Stimulus development experience
application.warnings = true
application.debug = false
window.Stimulus   = application

export { application }

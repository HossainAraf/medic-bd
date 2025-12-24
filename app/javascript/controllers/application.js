import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus
application.debug = process.env.NODE_ENV === "development"
window.Stimulus = application

// Global configuration
application.consumer = import("@rails/actioncable/src/consumer").then(module => module.createConsumer())

export { application }
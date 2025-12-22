import { application } from "./application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Eager load all controllers
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers (alternative approach)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
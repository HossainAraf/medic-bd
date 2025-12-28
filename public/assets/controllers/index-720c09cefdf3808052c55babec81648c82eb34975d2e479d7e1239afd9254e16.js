// Import and register all your controllers
import { application } from "./application"

// Import controllers here
import HelloController from "./hello_controller"
application.register("hello", HelloController)

// Import modal controller if you have it
import ModalController from "./modal_controller"
application.register("modal", ModalController);

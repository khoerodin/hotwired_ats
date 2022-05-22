// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import consumer from "./channels/consumer"
import CableReady from "cable_ready"
import mrujs from "mrujs";
import { CableCar } from "mrujs/plugins"
import * as ActiveStorage from "@rails/activestorage"
import "trix"
import "@rails/actiontext"

mrujs.start({
  plugins: [
    new CableCar(CableReady)
  ]
})

CableReady.initialize({ consumer })
ActiveStorage.start()

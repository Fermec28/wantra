// Entry point for the build script in your package.json
import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import "./controllers"
import "chartkick/chart.js"
import "tom-select/dist/css/tom-select.default.css"


Rails.start()
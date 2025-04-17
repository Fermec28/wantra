import { Application } from "@hotwired/stimulus"
import FabController from "./fab_controller"
import FiltersController from "./filters_controller"
import InlineEditController from "./inline_edit_controller"
import ModalController from "./modal_controller"
import TagSelectController from "./tag_select_controller"
import TourController from "./tour_controller"
import TransactionFormController from "./transaction_form_controller"

const application = Application.start()
application.register("fab", FabController)
application.register("filters", FiltersController)
application.register("inline-edit", InlineEditController)
application.register("modal", ModalController)
application.register("tag-select", TagSelectController)
application.register("tour", TourController)
application.register("transaction-form", TransactionFormController)

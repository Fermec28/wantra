// app/javascript/controllers/tour_controller.js
import { Controller } from "@hotwired/stimulus"
import Shepherd from "shepherd.js"
import "shepherd.js/dist/css/shepherd.css"


const t = (key) => {
  return key.split('.').reduce((obj, k) => obj?.[k], window.I18n?.tour) || key;
};
export default class extends Controller {
  connect() {
    if (localStorage.getItem("tour_shown")) return
    this.start()
  }

  start() {
    if (this.tour) {
      this.tour.start()
      return
    }
    this.tour = new Shepherd.Tour({
      useModalOverlay: true,
      defaultStepOptions: {
        scrollTo: { behavior: "smooth", block: "center" },
        cancelIcon: { enabled: true },
        classes: "shadow-md bg-white rounded-lg p-4",
        popperOptions: {
          modifiers: [{ name: "offset", options: { offset: [0, 16] } }]
        }
      }
    })

    
    this.addSteps()
    this.tour.start()
  }

  addSteps(){
    // 1. Bienvenida
    const showChecklist = document.querySelector(".onboarding-checklist")

    this.tour.addStep({
      id: "summary-cards",
      title: t("summary_cards.title"),
      text: t("summary_cards.text"),
      attachTo: { element: ".summary-cards", on: "bottom" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })

    // 2. Checklist
    if (showChecklist){
      this.tour.addStep({
        id: "onboarding-checklist",
        title: t("onboarding_checklist.title"),
        text: t("onboarding_checklist.text"),
        attachTo: { element: ".onboarding-checklist", on: "bottom" },
        buttons: [{ text: t("buttons.next"), action: this.tour.next }]
      })
    }
    // 3. Sidebar de cuentas
    this.tour.addStep({
      id: "sidebar-accounts",
      title: t("sidebar_accounts.title"),
      text: t("sidebar_accounts.text"),
      attachTo: { element: ".account-sidebar", on: "left" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })

    // 4. Presupuestos
    this.tour.addStep({
      id: "budgets",
      title: t("budgets.title"),
      text: t("budgets.text"),
      attachTo: { element: ".budget-overview", on: "bottom" },
      buttons: [
        { text: t("buttons.next"), action: this.tour.next }
      ]
    })

    // 5. Gráficas
    this.tour.addStep({
      id: "monthly-comparison",
      title: t("monthly_comparison.title"),
      text: t("monthly_comparison.text"),
      attachTo: { element: ".monthly-comparison-chart", on: "top" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "top-categories",
      title: t("top_categories.title"),
      text: t("top_categories.text"),
      attachTo: { element: ".top-categories-chart", on: "top" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "category-distribution",
      title: t("category_distribution.title"),
      text: t("category_distribution.text"),
      attachTo: { element: ".category-distribution-chart", on: "top" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "accumulated-flow",
      title: t("accumulated_flow.title"),
      text: t("accumulated_flow.text"),
      attachTo: { element: ".accumulated-flow-chart", on: "top" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "transactions-table",
      title: t("transactions_table.title"),
      text: t("transactions_table.text"),
      attachTo: { element: ".transactions-table", on: "left" },
      buttons: [ { text: t("buttons.next"), action: this.tour.next } ]
    })

    // 6. FAB - Menú de creación
    this.tour.addStep({
      id: "action-button",
      title: t("action_button.title"),
      text: t("action_button.text"),
      attachTo: { element: ".floating-action-button", on: "left" },
      buttons: [{
        text: t("action_button.button"),
        action: () => {
          document.querySelector(".floating-action-button").click()
          this.tour.next()
        }
      }]
    })

    // 7. Crear cuenta
    this.tour.addStep({
      id: "create-account",
      title: t("create_account.title"),
      text: t("create_account.text"),
      attachTo: { element: "[data-action='open-new-account-modal']", on: "right" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })

    // 8. Crear transacción
    this.tour.addStep({
      id: "create-transaction",
      title: t("create_transaction.title"),
      text: t("create_transaction.text"),
      attachTo: { element: "[data-action='open-new-transaction-modal']", on: "right" },
      buttons: [{ text: t("buttons.next"), action: this.tour.next }]
    })
    

    // 9. Crear presupuesto
    this.tour.addStep({
      id: "create-budget",
      title: t("create_budget.title"),
      text: t("create_budget.text"),
      attachTo: { element: "[data-action='open-new-budget-modal']", on: "right" },
      buttons: [{
        text: t("create_budget.button"),
        action: () => {
          localStorage.setItem("tour_shown", "true")
          this.tour.complete()
        }
      }]
    })
  }
}

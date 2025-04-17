// app/javascript/controllers/tour_controller.js
import { Controller } from "@hotwired/stimulus"
import Shepherd from "shepherd.js"
import "shepherd.js/dist/css/shepherd.css"

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
      title: "Resumen de tu dinero 💰",
      text: "Aquí puedes ver tu saldo total por moneda, cuánto has gastado o recibido en el período actual y el número de transacciones que llevas registradas. Es tu vista rápida del estado financiero.",
      attachTo: { element: ".summary-cards", on: "bottom" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })

    // 2. Checklist
    if (showChecklist){
      this.tour.addStep({
        id: "onboarding-checklist",
        title: "Checklist de inicio 📝",
        text: "Aquí te guiamos paso a paso para configurar tu cuenta y aprovechar todas las funcionalidades. Ideal si estás empezando.",
        attachTo: { element: ".onboarding-checklist", on: "bottom" },
        buttons: [{ text: "Siguiente", action: this.tour.next }]
      })
    }
    // 3. Sidebar de cuentas
    this.tour.addStep({
      id: "sidebar-accounts",
      title: "Tus cuentas 🏦",
      text: "En esta barra lateral puedes ver tus cuentas con su saldo actualizado. Siempre visible para facilitar el seguimiento.",
      attachTo: { element: ".account-sidebar", on: "left" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })

    // 4. Presupuestos
    this.tour.addStep({
      id: "budgets",
      title: "Presupuestos",
      text: "Consulta el progreso de tus presupuestos mensuales por categoría.",
      attachTo: { element: ".budget-overview", on: "bottom" },
      buttons: [
        { text: "Siguiente", action: this.tour.next }
      ]
    })

    // 5. Gráficas
    this.tour.addStep({
      id: "monthly-comparison",
      title: "Comparación mensual 📊",
      text: "Compara fácilmente tus ingresos y gastos de cada mes. Te ayuda a ver si estás gastando más de lo que ganas.",
      attachTo: { element: ".monthly-comparison-chart", on: "top" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "top-categories",
      title: "Tus gastos más importantes 🏷️",
      text: "Aquí ves cuáles son las categorías donde más gastas. Ideal para detectar hábitos o excesos.",
      attachTo: { element: ".top-categories-chart", on: "top" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "category-distribution",
      title: "Distribución por categoría 🎯",
      text: "Visualiza en qué estás gastando más. Puedes comparar por tipo de gasto y moneda.",
      attachTo: { element: ".category-distribution-chart", on: "top" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "accumulated-flow",
      title: "Flujo acumulado 💹",
      text: "Te muestra cómo evolucionan tus ingresos y gastos a lo largo del tiempo. Sirve para ver tendencias.",
      attachTo: { element: ".accumulated-flow-chart", on: "top" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })
    
    this.tour.addStep({
      id: "transactions-table",
      title: "Transacciones registradas",
      text: "Esta tabla muestra todas tus transacciones filtradas por período y otras opciones.",
      attachTo: { element: ".transactions-table", on: "left" },
      buttons: [ { text: "Siguiente", action: this.tour.next } ]
    })

    // 6. FAB - Menú de creación
    this.tour.addStep({
      id: "action-button",
      title: "Acciones rápidas ➕",
      text: "Haz clic aquí para agregar una cuenta, una transacción o un presupuesto. Todo lo esencial está a un clic.",
      attachTo: { element: ".floating-action-button", on: "left" },
      buttons: [{
        text: "Abrir menú",
        action: () => {
          document.querySelector(".floating-action-button").click()
          this.tour.next()
        }
      }]
    })

    // 7. Crear cuenta
    this.tour.addStep({
      id: "create-account",
      title: "Crear tu primera cuenta 💼",
      text: "Empieza por registrar una cuenta, como tu banco o billetera digital.",
      attachTo: { element: "[data-action='open-new-account-modal']", on: "right" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })

    // 8. Crear transacción
    this.tour.addStep({
      id: "create-transaction",
      title: "Registrar transacción 💸",
      text: "Luego podrás añadir tus ingresos y gastos desde este botón.",
      attachTo: { element: "[data-action='open-new-transaction-modal']", on: "right" },
      buttons: [{ text: "Siguiente", action: this.tour.next }]
    })
    

    // 9. Crear presupuesto
    this.tour.addStep({
      id: "create-budget",
      title: "Asignar presupuesto 📅",
      text: "Finalmente, puedes definir cuánto querés gastar por categoría cada mes.",
      attachTo: { element: "[data-action='open-new-budget-modal']", on: "right" },
      buttons: [{
        text: "Finalizar",
        action: () => {
          localStorage.setItem("tour_shown", "true")
          this.tour.complete()
        }
      }]
    })
  }
}

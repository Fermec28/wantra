class AddOptimizedIndexes < ActiveRecord::Migration[8.0]
  def change
    # Evita duplicados de nombre de etiquetas por usuario
    add_index :tags, [ :user_id, :name ], unique: true

    # Mejora búsquedas de transacciones por usuario y fecha
    add_index :transactions, [ :user_id, :date ]

    # Mejora búsquedas por tipo de transacción
    add_index :transactions, [ :user_id, :txn_kind ]

    # Mejora búsquedas de presupuestos por usuario y mes
    add_index :budgets, [ :user_id, :month ]

    # Mejora cálculos por tag, usuario y mes
    add_index :budgets, [ :user_id, :tag_id, :month ]
  end
end

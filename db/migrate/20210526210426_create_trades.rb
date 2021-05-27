class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.jsonb   :first_team, null: false, default: '{}'
      t.jsonb   :second_team, null: false, default: '{}'
      t.boolean :is_valid, default: true

      t.timestamps
    end
  end
end

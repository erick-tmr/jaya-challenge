class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :issue, foreign_key: true, null: false
      t.jsonb :payload, null: false
      t.string :action

      t.timestamps
    end
  end
end

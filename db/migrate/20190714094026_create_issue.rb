class CreateIssue < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.bigint :github_id, null: false

      t.timestamps
    end

    add_index :issues, :github_id, unique: true
  end
end

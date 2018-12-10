class CreateCriteria < ActiveRecord::Migration[5.2]
  def change
    create_table :criteria do |t|
      t.string :select
      t.integer :score
      t.string :rationale
      t.boolean :active, null: false, default: false
      t.references :search_profile, foreign_key: true
      t.references :aspect, index: true

      t.timestamps
    end
  end
end
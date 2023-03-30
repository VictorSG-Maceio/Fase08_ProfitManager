class CreateGains < ActiveRecord::Migration[7.0]
  def change
    create_table :gains do |t|
      t.string :description
      t.float :value
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

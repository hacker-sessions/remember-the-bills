class CreateReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :reminders do |t|
      t.references :user, foreign_key: true
      t.string :label
      t.date :due_date
      t.integer :status
      t.decimal :amount
      t.boolean :recurrent

      t.timestamps
    end
  end
end

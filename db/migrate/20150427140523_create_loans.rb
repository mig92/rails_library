class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :user_id
      t.integer :book_id
      t.date :return_date

      t.timestamps
    end
  end
end

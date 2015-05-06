class AddBorrowedToBook < ActiveRecord::Migration
  def change
    add_column :books, :borrowed, :boolean
  end
end

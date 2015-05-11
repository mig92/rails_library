class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.references :user
      t.references :book

      t.timestamps
    end
    add_index :wishlists, :user_id
    add_index :wishlists, :book_id
  end
end

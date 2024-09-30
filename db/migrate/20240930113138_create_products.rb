class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.string :warranty_information
      t.string :shipping_information
      t.string :availability_status
      t.string :return_policy
      t.integer :min_order_quantity
      t.string :barcode
      t.string :qrcode
      t.float :rating
      t.integer :stock

      t.timestamps
    end
  end
end

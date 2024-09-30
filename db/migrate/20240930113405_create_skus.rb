class CreateSkus < ActiveRecord::Migration[7.0]
  def change
    create_table :skus do |t|
      t.string :name
      t.float :weight
      t.float :width
      t.float :height
      t.float :depth
      t.float :price
      t.float :discount_percentage
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end

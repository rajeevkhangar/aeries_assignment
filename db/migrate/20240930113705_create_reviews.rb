class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.float :rating
      t.text :comment
      t.string :name
      t.string :email
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end

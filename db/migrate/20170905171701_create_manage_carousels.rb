class CreateManageCarousels < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_carousels do |t|
      t.string :image
      t.string :link
      t.boolean :show, default: true
      t.integer :index

      t.timestamps
    end
  end
end

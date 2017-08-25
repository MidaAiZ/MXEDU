class CreateManageImage < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_images do |t|
      t.string :link

      t.timestamps null: false
    end
  end
end

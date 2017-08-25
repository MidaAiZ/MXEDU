class CreateManageFileworkers < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_fileworkers do |t|
        t.string :file

        t.timestamps null: false
    end
  end
end

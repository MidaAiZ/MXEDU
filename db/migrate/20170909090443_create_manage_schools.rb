class CreateManageSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_schools do |t|
      t.string :city
      t.string :name
      t.string :cate
      t.string :sign
      t.jsonb :info

      t.timestamps
    end
  end
end

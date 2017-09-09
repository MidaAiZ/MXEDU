class CreateIndexMeterials < ActiveRecord::Migration[5.1]
  def change
    create_table :index_meterials do |t|
      t.string :name
      t.string :cate
      t.string :tag
      t.string :attach
      t.references :school
      t.references :admin
      t.jsonb :info

      t.timestamps
    end

    add_index :index_meterials, :name, name: :index_meterials_on_name
    add_index :index_meterials, [:cate, :tag], name: :index_meterials_on_cate_tag
    add_index :index_meterials, :school_id, name: :index_meterials_on_scholl_id
    add_index :index_meterials, :admin_id, name: :index_meterials_on_admin_id
  end
end

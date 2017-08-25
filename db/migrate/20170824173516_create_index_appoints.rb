class CreateIndexAppoints < ActiveRecord::Migration[5.1]
  def change
    create_table :index_appoints do |t|
      t.string :name
      t.string :phone
      t.string :content
      t.string :time
      t.references :user, index: true

      t.timestamps
    end
  end
end

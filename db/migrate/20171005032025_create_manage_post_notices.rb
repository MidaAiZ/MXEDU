class CreateManagePostNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :manage_post_notices do |t|
      t.string :name
      t.string :content
      t.string :cate
      t.references :school
      t.references :admin

      t.timestamps
    end
    add_index :manage_post_notices, :school_id, name: :manage_post_notices_on_school_id
  end
end

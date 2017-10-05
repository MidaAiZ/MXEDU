class AddDetailsToManagePostNotices < ActiveRecord::Migration[5.1]
  def change
    change_table :manage_post_notices do |t|
        t.rename :name, :title
        t.integer :readtimes, default: 0
        t.boolean :is_deleted, default: false
    end
  end
end

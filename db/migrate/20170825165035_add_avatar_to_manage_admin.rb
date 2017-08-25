class AddAvatarToManageAdmin < ActiveRecord::Migration[5.1]
  def change
    change_table :manage_admins do |t|
        t.string :avatar
    end
  end
end

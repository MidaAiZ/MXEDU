class AddRemoteIpToIndexThumbs < ActiveRecord::Migration[5.1]
  def change
	  change_table :index_thumbs do |t|
		t.string :remote_ip
	  end
	  add_index :index_thumbs, :remote_ip, name: :index_thumbs_on_remote_ip
  end
end

class AddTimesToIndexHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :index_histories, :times, :integer, default: 0
  end
end

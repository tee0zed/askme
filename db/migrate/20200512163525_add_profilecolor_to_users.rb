class AddProfilecolorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profilecolor, :integer, default: 1
  end
end

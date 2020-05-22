class ChangeProfilecolorDeafult < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :profilecolor
    add_column :users, :profilecolor, :string, default: "#4f8bc0"
  end
end

class AddProfilecolorToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profilecolor, :string, default: "4f8bc0"
  end
end

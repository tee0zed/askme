class AddProfilecolorToUsers < ActiveRecord::Migration[6.0]
  add_column :users, :profilecolor, :string, default: "4f8bc0"
end

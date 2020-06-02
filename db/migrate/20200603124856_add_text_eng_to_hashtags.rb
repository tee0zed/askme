class AddTextEngToHashtags < ActiveRecord::Migration[6.0]
  def change
    add_column :hashtags, :text_eng, :string
  end
end

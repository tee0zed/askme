class CreateQuestionHashtags < ActiveRecord::Migration[6.0]
  def change
    create_table :question_hashtags do |t|
      t.belongs_to :hashtag
      t.belongs_to :question
      t.timestamps
    end
  end
end

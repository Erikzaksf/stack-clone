class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :content, :text

      t.timestamps
    end
    
    create_table :votes do |t|
      t.column :user_id, :integer
      t.column :question_id, :integer
      t.column :is_upvote, :boolean

      t.timestamps
    end
  end
end

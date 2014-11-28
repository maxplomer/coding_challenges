class CreateSkeletonAnswers < ActiveRecord::Migration
  def change
    create_table :skeleton_answers do |t|
      t.text :method_skeleton, :null => false
      t.text :answer, :null => false
      t.integer :challenge_id, :null => false
      t.text :language, :null => false

      t.timestamps
    end
  end
end

class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name, :null => false
      t.string :difficulty, :null => false
      t.string :description, :null => false
      t.string :problem_statement, :null => false
      t.string :method_skeleton, :null => false
      t.string :answer, :null => false

      t.timestamps
    end
  end
end

class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name, :null => false
      t.string :difficulty, :null => false
      t.text :description, :null => false
      t.text :problem_statement, :null => false
      t.text :method_skeleton, :null => false
      t.text :answer, :null => false

      t.timestamps
    end
  end
end

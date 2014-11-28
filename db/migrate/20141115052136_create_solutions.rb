class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :user_id, :null => false
      t.integer :challenge_id, :null => false
      t.text :method_string, :null => false
      t.boolean :success, :null => false
      t.text :language, :null => false

      t.timestamps
    end
  end
end

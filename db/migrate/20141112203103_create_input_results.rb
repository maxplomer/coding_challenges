class CreateInputResults < ActiveRecord::Migration
  def change
    create_table :input_results do |t|
      t.integer :challenge_id, :null => false
      t.text :input, :null => false
      t.text :result, :null => false

      t.timestamps
    end
  end
end

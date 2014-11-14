class CreateInputResults < ActiveRecord::Migration
  def change
    create_table :input_results do |t|
      t.integer :challenge_id, :null => false
      t.string :input, :null => false
      t.string :result, :null => false

      t.timestamps
    end
  end
end

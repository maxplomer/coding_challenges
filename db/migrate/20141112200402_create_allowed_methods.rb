class CreateAllowedMethods < ActiveRecord::Migration
  def change
    create_table :allowed_methods do |t|
      t.integer :challenge_id, :null => false
      t.string :method, :null => false
      
      t.timestamps
    end
  end
end

class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :challenge_id, :null => false
      t.string :url, :null => false

      t.timestamps
    end
  end
end

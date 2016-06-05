class CreatePosts < ActiveRecord::Migration
  def change
  create_table :posts do |t|
  		t.text :creator
  		t.text :body
  		
  		t.timestamps
  	end
  end
end

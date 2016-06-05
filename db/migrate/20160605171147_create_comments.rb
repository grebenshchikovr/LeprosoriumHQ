class CreateComments < ActiveRecord::Migration
  def change
  create_table :comments do |t|
  		t.text :username
  		t.text :comment
  		t.text :postID
  		
  		t.timestamps
  	end
  end
end

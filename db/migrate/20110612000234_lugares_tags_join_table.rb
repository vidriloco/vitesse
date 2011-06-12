class LugaresTagsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :lugares_tags, :id => false do |t|
      t.integer :lugar_id, :null => false
      t.integer :tag_id, :null => false
    end
  end

  def self.down
    drop_table :lugares_tags
  end
end

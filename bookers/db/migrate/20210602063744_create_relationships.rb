class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["followed_id"], name: "index_relationships_on_followed_id"
      t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
      t.index ["follower_id"], name: "index_relationships_on_follower_id"

      t.timestamps
    end
  end
end

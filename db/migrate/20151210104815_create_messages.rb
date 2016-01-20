class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.string :url
      t.string :img_url
      t.integer :user_from
      t.integer :user_to
      t.timestamps
    end
  end
end


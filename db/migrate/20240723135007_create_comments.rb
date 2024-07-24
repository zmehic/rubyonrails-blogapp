class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.belongs_to :blog_post, null: false, foreign_key: true
      t.string :user
      t.text :body
      t.integer :likes

      t.timestamps
    end
  end
end

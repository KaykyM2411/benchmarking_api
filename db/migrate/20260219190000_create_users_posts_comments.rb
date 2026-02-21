class CreateUsersPostsComments < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps null: false
    end
    add_index :users, :email, unique: true

    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps null: false
    end

    create_table :comments do |t|
      t.text :body, null: false
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps null: false
    end
  end
end

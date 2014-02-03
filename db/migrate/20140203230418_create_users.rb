class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, limit: 50
      t.string :email, limit: 50
      t.string :auth_token, limit: 50
      t.string :password, limit: 50

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end

class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
          t.string :name, null: false
      t.string :password_digest, null: false
    end

    add_index :users, :name, unique: true

  end
end

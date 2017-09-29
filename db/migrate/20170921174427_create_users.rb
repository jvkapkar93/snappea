class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.text :address
      t.string :mobile
      t.string :auth_token

      t.timestamps
    end
  end
end

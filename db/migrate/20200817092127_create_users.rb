class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.references :role, null: false, foreign_key: true, default: 1

      t.timestamps
    end
  end
end

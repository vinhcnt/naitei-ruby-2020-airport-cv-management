class AddUnitToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :unit, null: true, foreign_key: true
  end
end

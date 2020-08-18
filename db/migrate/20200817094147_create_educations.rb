class CreateEducations < ActiveRecord::Migration[6.0]
  def change
    create_table :educations do |t|
      t.string :college
      t.string :major
      t.date :date_from
      t.date :date_to
      t.text :certification
      t.text :additional_information
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end

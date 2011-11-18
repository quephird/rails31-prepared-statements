class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :last_name
      t.string :first_name
      t.string :ssn
      t.integer :age

      t.timestamps
    end
  end
end

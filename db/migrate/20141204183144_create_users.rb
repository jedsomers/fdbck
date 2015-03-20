class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :answer1
      t.string :answer2

      t.timestamps null: false
    end
  end
end

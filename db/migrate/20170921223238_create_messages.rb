class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :received
      t.string :reply

      t.timestamps
    end
  end
end

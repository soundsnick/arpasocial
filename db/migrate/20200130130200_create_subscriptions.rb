class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :from_id
      t.integer :to_id
      t.timestamps
    end
  end
end

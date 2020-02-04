class ChangeFromIdToUserId < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :from_id
    add_column :subscriptions, :user_id, :integer
  end
end

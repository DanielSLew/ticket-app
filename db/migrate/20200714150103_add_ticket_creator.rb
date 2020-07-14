class AddTicketCreator < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :user_id, :integer
    add_foreign_key :tickets, :users
  end
end

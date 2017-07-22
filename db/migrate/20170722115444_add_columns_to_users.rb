class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :name, :string
    add_column :users, :birth_date, :date
    add_column :users, :bio, :text
  end
end

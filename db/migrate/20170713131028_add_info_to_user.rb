class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :no, :integer
  end
end

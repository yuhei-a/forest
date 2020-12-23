class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_image_id, :integer
    add_column :users, :gender, :integer, default: 0
    add_column :users, :introduction, :string
    add_column :users, :bloodtype, :integer, default: 0
    add_column :users, :sign, :integer, default: 0
    add_column :users, :prefectures, :integer, default: 0
  end
end

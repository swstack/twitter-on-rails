class UpdateUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :api_token
      t.string :api_secret
      t.string :screen_name
    end
  end
end

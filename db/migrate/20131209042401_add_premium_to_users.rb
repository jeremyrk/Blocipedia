class AddPremiumToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :premium
    end
  end
end

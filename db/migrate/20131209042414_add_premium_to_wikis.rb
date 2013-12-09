class AddPremiumToWikis < ActiveRecord::Migration
  def change
    change_table :wikis do |t|
      t.boolean :private
    end
  end
end

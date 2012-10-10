class AddOneTimeToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :one_time, :boolean
  end
end

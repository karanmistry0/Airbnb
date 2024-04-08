class AddAverageOverallRatingToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :average_overall_rating, :decimal
  end
end

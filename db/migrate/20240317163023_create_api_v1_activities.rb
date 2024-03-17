class CreateApiV1Activities < ActiveRecord::Migration[7.1]
  def change
    create_table :api_v1_activities do |t|
      t.string :name
      t.references :tour, null: false, foreign_key: { to_table: :api_v1_tours }

      t.timestamps
    end
  end
end

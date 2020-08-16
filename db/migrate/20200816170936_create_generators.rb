class CreateGenerators < ActiveRecord::Migration[6.0]
  def change
    create_table :generators do |t|
      t.string :name
      t.string :api_url
      t.string :description

      t.timestamps
    end
  end
end

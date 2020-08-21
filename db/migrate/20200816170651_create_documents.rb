class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :prompt
      t.integer :length, :default => 1000
      t.text :generated_response
      t.boolean :is_continuation, :default => false
      t.boolean :start_at_beginning, :default => true
      t.boolean :pause_at_end, :default => false
      t.float :top_p, :default => 0.9
      t.float :temperature, :default => 1.00
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :generator, null: false, foreign_key: true

      t.timestamps
    end
  end
end

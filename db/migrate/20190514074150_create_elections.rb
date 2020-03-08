class CreateElections < ActiveRecord::Migration[5.2]
  def change
    create_table :elections do |t|
      t.string :position
      t.datetime :deadline
      t.datetime :start_time
      t.datetime :end_time
      t.string :session
      t.json :vote_count
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end

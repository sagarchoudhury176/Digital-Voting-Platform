class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.text :data
      t.references :election, foreign_key: true
      t.references :candidate, foreign_key: true
      t.references :user, foreign_key: true
      t.references :vote, foreign_key: true

      t.timestamps
    end
  end
end

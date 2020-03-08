class CreateNominations < ActiveRecord::Migration[5.2]
  def change
    create_table :nominations do |t|
      t.references :candidate, foreign_key: true
      t.references :election, foreign_key: true

      t.timestamps
    end
  end
end

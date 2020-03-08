class CreateCandidate < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :affilation, default: ''
      t.text :past_experiences, default: ''
      t.text :about_me, default: ''
      t.text :link, default: ''
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

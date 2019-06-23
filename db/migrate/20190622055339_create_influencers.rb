class CreateInfluencers < ActiveRecord::Migration[5.2]
  def change
    create_table :influencers do |t|
      t.string :name
      t.string :instagram
      t.string :twitter
      t.date :birth_date
      t.date :signup_date

      t.timestamps
    end
  end
end

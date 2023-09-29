class CreateRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :rewards do |t|
      t.string :to
      t.string :from
      t.text :message

      t.timestamps
    end
  end
end

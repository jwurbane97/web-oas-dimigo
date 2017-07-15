class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :accepted
      t.datetime :sch_start
      t.datetime :sch_end
      t.string :reason

      t.timestamps null: false
    end
  end
end

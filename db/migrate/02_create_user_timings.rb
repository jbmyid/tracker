class CreateUserTimings < ActiveRecord::Migration
  def change
    create_table :user_timings do |t|
      t.integer :user_id
      t.datetime :entry_time

      t.timestamps
    end
  end
end

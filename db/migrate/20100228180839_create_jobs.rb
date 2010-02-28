class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :reference
      t.string :title
      t.text :description
      t.text :profile
      t.datetime :start_published_at
      t.datetime :end_published_at
      t.datetime :deleted_at
      t.integer :job_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end

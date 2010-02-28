class CreateJobCategories < ActiveRecord::Migration
  def self.up
    create_table :job_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :job_categories
  end
end

class CreateJobApplies < ActiveRecord::Migration
  def self.up
    create_table :job_applies do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.text :motivation
      t.integer :job_id

      t.timestamps
    end
  end

  def self.down
    drop_table :job_applies
  end
end

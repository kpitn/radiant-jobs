class CreateJobApplyAttachments < ActiveRecord::Migration
  def self.up
    create_table :job_apply_attachments do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height
      t.integer :width
      t.integer :parent_id
      t.string :thumbnail
      t.integer :db_file_id
      t.integer :job_apply_id

      t.timestamps
    end
  end

  def self.down
    drop_table :job_apply_attachments
  end
end

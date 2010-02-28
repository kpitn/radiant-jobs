class Job < ActiveRecord::Base

  belongs_to :job_category

  validates_presence_of :title, :description, :profile#, :location
  validates_uniqueness_of :reference
end

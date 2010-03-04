class JobsExtension < Radiant::Extension
  version "0.0.1"
  description "Allows to manage careers"
  url "http://wiki.github.com/kpitn/radiant-jobs/"

  define_routes do |map|
    map.namespace(:admin)  do |admin|
      admin.resources :jobs
      admin.resources :job_categories
      admin.resources :job_applies
      admin.resources :job_apply_attachments
    end
  end

  def activate
    Page.send(:include, JobTags)

    tab 'Carrers' do
     add_item("Jobs", "/admin/jobs")
     add_item("Job Categories", "/admin/job_categories")
     add_item("Job Applies", "/admin/job_applies")
   end
  end
end


require_dependency 'application_controller'

class JobExtension < Radiant::Extension
  version "0.0.1"
  description "Allows to manage careers"
  url "http://wiki.github.com/kpitn/radiant-jobs/"

  define_routes do |map|
    map.namespace(:admin)  do |admin|
      admin.resources :jobs do |job|
        job.resources :job_applies
      end
      admin.resources :job_applies
      admin.resources :job_categories
      
      admin.resources :job_apply_attachments
    end
    map.resources 'jobs' do |job|
      job.resources  'job_applies'

    end
  end

  def activate
    Page.send(:include, JobTags)
    JobPageIndex
    JobPageShow
    tab 'Careers' do
     add_item("Jobs", "/admin/jobs")
     add_item("Job Categories", "/admin/job_categories")
     add_item("Job Applies", "/admin/job_applies")
   end
   
    #add Radiant Render
    SiteController.send :include, SiteControllerExtension
  end
end


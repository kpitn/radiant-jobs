class JobPageShow < Page

  include Radiant::Taggable
  
  tag "job" do |tag|
    job_index = $1 if request_uri =~ %r{\/jobs\/([\d]*)$}
    tag.locals.job = Job.find(job_index )
    tag.expand unless tag.locals.job.nil?
  end

  tag "title" do |tag|
    job_index = $1 if request_uri =~ %r{\/jobs\/([\d]*)$}
    job = Job.find(job_index)
    page = tag.locals.page
    if job
      job.title
    else
      page.title
    end

  end
  
end
module JobTags

  include Radiant::Taggable

  class JobTagError < StandardError; end

  tag "jobs" do |tag|
    tag.expand
  end

  desc %{
    Usage:
    <pre><code><r:jobs:each >...</r:jobs:each></code></pre>
      Iterates through all jobs items }
  tag "jobs:each" do |tag|
    content = ''
    options = {}

   
   @jobs.each do |job|
      tag.locals.job = job
      content << tag.expand
    end
    content
  end

  desc %{
    Usage:
    <pre><code><r:job [id='id'] [name='name'] [keywords='key1, key2, key3']>...</r:job></code></pre>
    Selects current job }
  tag "job" do |tag|
    tag.locals.job = find_job(tag)
    tag.expand unless tag.locals.job.nil?
  end

  desc %{
    Usage:
    <pre><code><r:job:id /></code></pre>
    Provides id for current job }
  tag "job:id" do |tag|
    job = tag.locals.job
    job.id
  end

  desc %{
    Usage:
    <pre><code><r:job:title /></code></pre>
    Provides title for current job }
  tag "job:title" do |tag|
    job = tag.locals.job
    job.title
  end

  desc %{
    Usage:
    <pre><code><r:job:reference /></code></pre>
    Provides reference for current job }
  tag "job:reference" do |tag|
    job = tag.locals.job
    job.reference
  end

  desc %{
    Usage:
    <pre><code><r:job:description /></code></pre>
    Provides description for current job }
  tag "job:description" do |tag|
    job = tag.locals.job
    job.description
  end

  desc %{
    Usage:
    <pre><code><r:job:profile /></code></pre>
    Provides profile for current job }
  tag "job:profile" do |tag|
    job = tag.locals.job
    job.profile
  end

  desc %{
    Usage:
    <pre><code><r:job:category /></code></pre>
    Provides profile for current job }
  tag "job:category" do |tag|
    job = tag.locals.job
    job.job_category.name if job.job_category
  end

  desc %{
    Usage:
    <pre><code><r:job:published_at /></code></pre>
    Provides published_date for current job }
  tag "job:published_at" do |tag|
    job = tag.locals.job
    I18n.l(job.start_published_at,:formats=>:default) if job.start_published_at
  end

  desc %{
    Usage:
    <pre><code><r:searchlogic /></code></pre>
    Provides form for sarchlogic }
  tag "searchlogic" do |tag|
    tag.attr['id'] ||= 'search_form'
    options = []
    JobCategory.all.each do |category|
        options << "<option value='#{category.id}'>#{category.name}</option>"
    end
    categories =  "<select id='search_job_category_id_equals' name='search[job_category_id_equals]'>#{options}</select>"


    results = [] 
    results << %(<form  method="post" actions='/jobs'>)
    results <<   categories
    results <<    "<input type='submit' value='Valider'/>"
    results << %(</form>)   
  end

  desc %{
    Usage:
    <pre><code><r:searchlogic:category /></code></pre>
    Provides form for sarchlogic }
  tag "searchlogic:category" do |tag|
    options = []
    JobCategory.all.each do |category|
        options << "<option value='#{category.id}'>#{category.name}</option>"
    end
    return "<select id='search_category_id_equals' name='search_[category_id_equals]'>#{options}</select>"

    
  end

  desc %{
    Usage:
    <pre><code><r:searchlogic:reference /></code></pre>
    Provides form for sarchlogic }
  tag "searchlogic:reference" do |tag|
   "<input type='text' id='search_reference_like' name='search_[reference_like]'/>"
  end

  desc %{
    Usage:
    <pre><code><r:searchlogic:submit /></code></pre>
    Provides form for sarchlogic }
  tag "searchlogic:submit" do |tag|
   "<input type='submit' value='Valider'/>"
  end



  protected

  def find_job(tag)
    if tag.locals.job
      tag.locals.job
    elsif tag.attr["name"]
      Job.find_by_title tag.attr["title"]
    elsif tag.attr["id"]
      Job.find_by_id tag.attr["id"]
    elsif @current_job
      @current_job
    end
  end

end
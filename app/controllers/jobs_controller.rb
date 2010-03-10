class JobsController < SiteController
  no_login_required

  def index
    @search = Job.search(params[:search])
    @jobs = @search.paginate(:per_page => 4, :page => params[:page], :order => "start_published_at DESC")
    radiant_render :page => "/jobs"
  end

  def show
    @job = Job.find(params[:id])
    radiant_render :page => "/jobs"
  end
end
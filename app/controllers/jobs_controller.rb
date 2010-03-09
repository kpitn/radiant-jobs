class JobsController < SiteController
  no_login_required

  def index
    @search = Job.search(params[:search])
    @jobs = @search.all
    radiant_render :page => "/jobs"
  end

  def show
    @job = Job.find(params[:id])
    radiant_render :page => "/jobs"
  end
end
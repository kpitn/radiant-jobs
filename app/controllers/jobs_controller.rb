class JobsController < SiteController
  no_login_required

  def index
    radiant_render :page => "/jobs"
  end
end
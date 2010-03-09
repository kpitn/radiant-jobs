class JobAppliesController < SiteController
  no_login_required
  before_filter :find_job

 
  def new
    @job_apply = @job.job_applies.new

    radiant_render :page => "/jobs"
  end

  def create
    @job_apply = @job.job_applies.new(params[:job_apply])
    if @job_apply.save
      flash[:notice] == 'Votre candidatre a bien été enregistrée.'
      redirect_to job_path(@job)
    else
      flash[:error] == "Une erreur s'est produite lors de l'enregirstrement."
      redirect_to :back
    end
  end

  private

  def find_job
    @job = Job.find(params[:job_id])
  end
end
class Admin::JobsController < Admin::ResourceController
  before_filter :find_job, :except => [:index, :new, :create]
  model_class Job

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(params[:job])
    if @job.save
      flash[:notice] = 'Job créé.'
      redirect_to admin_jobs_path
    else
      flash[:error] = "Une erreur s'est produite lors de l'enregistrement du job."
      redirect_to new_admin_job_path
    end
  end

  def edit    
  end

  def destroy
    if @job.destroy
      flash[:notice] = 'Job supprimé.'
      redirect_to admin_jobs_path
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression du job."
      redirect_to admin_jobs_path
    end
  end


  private

  def find_job
    @job = Job.find(params[:id])
  end
end
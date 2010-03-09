class Admin::JobAppliesController < Admin::ResourceController


  def index
    @job_applies = JobApply.all
  end

  def show
    @job = Job.find(params[:job_id])
    @job_apply = @job.job_applies.find(params[:id])
  end

end
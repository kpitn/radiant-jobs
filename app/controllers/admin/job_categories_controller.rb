class Admin::JobCategoriesController < Admin::ResourceController
   before_filter :find_job_category, :except => [:index, :new, :create]
   model_class JobCategory

  def index
    @job_category = JobCategory.all
  end

  def new
    @job_category = JobCategory.new
  end

  def create
    @job_category = JobCategory.new(params[:job_category])
    if @job_category.save
      flash[:notice] = 'Catégorie créée.'
      redirect_to admin_job_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de l'enregistrement de la catégeoris."
      redirect_to new_admin_job_categories_path
    end
  end

  def edit
  end

  def destroy
    if @job_category.destroy
      flash[:notice] = 'Catégorie supprimée.'
      redirect_to admin_job_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la suppression de la catégorie."
      redirect_to admin_job_categories_path
    end
  end


  private

  def find_job_category
    @job_category = JobCategory.find(params[:id])
  end
end
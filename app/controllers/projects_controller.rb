class ProjectsController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      project_successfully(:created)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      project_successfully(:updated)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    project_successfully(:destroyed, projects_path)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def project_successfully(action, path=project_path(@project))
    redirect_to path, notice: "Project was successfully #{action}."
  end
end